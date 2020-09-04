import 'dart:io';

import 'package:camera/camera.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/cityscan_qrcode.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:citycollection/screens/scan_tabs/camera_tab.dart';
import 'package:citycollection/screens/scan_tabs/qr_scanner_tab.dart';
import 'package:citycollection/screens/scan_tabs/throw_tab.dart';
import 'package:citycollection/screens/scan_tabs/winner_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/indicator/line_scale_party_indicator.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';
import 'package:loading/loading.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  ScanBloc _scanBloc;
  bool _hasQrCodeBeenFound = false;
  TabController _tabController;
  CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _isWasteImageUploading = false;
  bool _isUploadingImageSuccessful = false;
  String _currentImageSrc;
  ScanWinnings _currentScanWinnings;
  bool _isScanWinningsWaiting = true;

  @override
  void initState() {
    super.initState();
    _scanBloc = ScanBloc(GetIt.instance<DataRepository>());
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _scanBloc.close();
    _tabController.dispose();
    //BlocProvider.of<AuthBloc>(context).signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _scanBloc,
          child: BlocListener<ScanBloc, ScanState>(
              cubit: _scanBloc,
              listener: (context, state) {
                //qrcode tab
                if (state is CorrectQrScanned) {
                  setState(() {
                    _isCameraInitialized = true;
                    _hasQrCodeBeenFound = true;
                    _cameraController = state.cameraController;
                  });
                  Future.delayed(Duration(seconds: 1), () async {
                    _tabController.animateTo(1,
                        duration: Duration(milliseconds: 300));
                  });
                } else if (state is CameraInitiailizedFailed) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            title: Text("Whoops!"),
                            content: Text(
                              "An error has occured with your camera, try scanning again.",
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ));
                  //camera tab
                } else if (state is ValidImageTakenState) {
                } else if (state is InvalidImageTakenState) {
                } else if (state is ErrorScanValidationState) {
                  Navigator.of(context).pop();
                } else if (state is WasteImageUploadingState) {
                  setState(() {
                    _isWasteImageUploading = true;
                    _currentImageSrc = state.filepath;
                  });
                } else if (state is WasteImageSuccessState) {
                  setState(() {
                    _isUploadingImageSuccessful = true;
                  });
                  Future.delayed(Duration(seconds: 2), () {
                    _tabController.animateTo(2,
                        duration: Duration(milliseconds: 300));
                    _cameraController.dispose();
                  });
                } else if (state is FailedToTakeWasteImage) {
                  Navigator.of(context).pop();
                } else if (state is WasteImageFailedUploadState) {
                  Navigator.of(context).pop();
                  //throwing tab
                } else if (state is DoneThrowingItemState) {
                  _tabController.animateTo(3,
                      duration: Duration(milliseconds: 300));
                  //winnning tab
                } else if (state is WinningScanStateState) {
                  Future.delayed(Duration(seconds: 5), () {
                    setState(() {
                      _currentScanWinnings = state.scanWinnings;
                      _isScanWinningsWaiting = false;
                    });
                  });
                } else if (state is NoScanWinningsState) {
                  Future.delayed(Duration(seconds: 5), () {
                    setState(() {
                      _isScanWinningsWaiting = false;
                    });
                  });
                }
              },
              child: Stack(
                children: <Widget>[
                  TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      QrScannerTab(
                          hasQrCodeBeenFound: _hasQrCodeBeenFound,
                          qrKey: _qrKey,
                          scanBloc: _scanBloc,
                          context: context),
                      CameraTab(
                          context: context,
                          isCameraInitialized: _isCameraInitialized,
                          cameraController: _cameraController,
                          currentImageSrc: _currentImageSrc,
                          isWasteImageUploading: _isWasteImageUploading,
                          isUploadingImageSuccessful:
                              _isUploadingImageSuccessful),
                      ThrowingTab(),
                      WinnerTab(
                        scanWinnings: _currentScanWinnings,
                        isWaiting: _isScanWinningsWaiting,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: CityColors.primary_teal,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
