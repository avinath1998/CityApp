import 'dart:io';

import 'package:camera/camera.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/cityscan_qrcode.dart';
import 'package:citycollection/networking/data_repository.dart';
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
  QRViewController _qrController;
  String _qrResult = "Qr Code Not Found";
  ScanBloc _scanBloc;
  bool _hasQrCodeBeenFound = false;
  TabController _tabController;
  CameraController _cameraController;
  List<CameraDescription> cameras;
  bool _isCameraInitialized = false;
  bool _isWasteImageUploading = false;
  bool _isUploadingImageSuccessful = false;
  final String imageSrc =
      "https://scontent.fcmb2-1.fna.fbcdn.net/v/t1.0-9/51304218_1009362682520865_567715382844981248_n.jpg?_nc_cat=105&_nc_sid=8bfeb9&_nc_oc=AQnCuxTKQvGVFbZpvozovDm9hNCPaIyKY9fv4SHYDhiUmMZoFlBm8rJ3Zmi6stvxLOk&_nc_ht=scontent.fcmb2-1.fna&oh=93b016f1b999b21da3724a40eca299d1&oe=5F198CAC";
  String _currentImageSrc;

  @override
  void initState() {
    super.initState();
    _scanBloc = ScanBloc(GetIt.instance<DataRepository>());
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _scanBloc.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "CityScan",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0))
            ]),
          ),
        ),
        body: BlocListener<ScanBloc, ScanState>(
            bloc: _scanBloc,
            listener: (context, state) {
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
                              child: Text("Go Home"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ));
              } else if (state is ValidImageTakenState) {
              } else if (state is InvalidImageTakenState) {
              } else if (state is ErrorScanValidationState) {
              } else if (state is WasteImageSuccessState) {
                setState(() {
                  _isUploadingImageSuccessful = true;
                });
                Future.delayed(Duration(seconds: 2), () async {
                  _tabController.animateTo(2,
                      duration: Duration(milliseconds: 300));
                });
              } else if (state is WasteImageUploadingState) {
                setState(() {
                  _isWasteImageUploading = true;
                  _currentImageSrc = state.filepath;
                });
              } else if (state is FailedToTakeWasteImage) {
              } else if (state is WasteImageFailedUploadState) {}
            },
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                _buildQRScannerTab(),
                _buildCameraTab(),
                _buildThrowingScreen()
              ],
            )),
      ),
    );
  }

  Widget _buildQRScannerTab() {
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeInExpo,
      switchInCurve: Curves.easeOutExpo,
      duration: Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: !_hasQrCodeBeenFound
          ? Stack(
              children: <Widget>[
                QRView(
                  key: _qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    _scanBloc.add(QRViewCreatedEvent(controller));
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      color: Colors.black12,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Scan QR",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Scan QR on bin.",
                              key: ValueKey("pointText"),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Column(
                              key: ValueKey("findingColumn"),
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Loading(
                                      indicator: LineScaleIndicator(),
                                      size: 30,
                                      color: Colors.white),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Finding QR code...",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Loading(
                      indicator: BallGridPulseIndicator(),
                      size: 60,
                      color: Colors.white),
                )
              ],
            )
          : Column(
              key: ValueKey("QrFoundScanKey"),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 100.0,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CityColors.primary_teal,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "QR Code Found.",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
    );
  }

  Widget _buildCameraTab() {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return AnimatedSwitcher(
      switchInCurve: Curves.easeInExpo,
      switchOutCurve: Curves.easeOutExpo,
      duration: Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: _isCameraInitialized
          ? Stack(children: <Widget>[
              Center(
                child: Transform.scale(
                  scale: _cameraController.value.aspectRatio / deviceRatio,
                  child: AspectRatio(
                    aspectRatio: _cameraController.value.aspectRatio,
                    child: CameraPreview(_cameraController),
                  ),
                ),
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 400),
                vsync: this,
                curve: Curves.easeOut,
                child: _isWasteImageUploading && _currentImageSrc != null
                    ? Align(
                        key: Key("KeyOneAlign"),
                        alignment: Alignment.center,
                        child: Image.file(
                          File(_currentImageSrc),
                          frameBuilder:
                              (context, child, frame, wasSyncholoaded) {
                            return Container(
                              margin: const EdgeInsets.all(30.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              child: ClipRRect(
                                  child: child,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                            );
                          },
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        key: Key("KeyTwoContainer"),
                        height: 1,
                        width: 1,
                      ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: AnimatedSize(
                      vsync: this,
                      curve: Curves.bounceOut,
                      duration: Duration(milliseconds: 400),
                      child: !_isWasteImageUploading
                          ? Card(
                              key: Key("cardOne"),
                              color: Colors.black12,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Capture Item",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "Take a picture of your ${_scanBloc.currentCityScanQrCode.wasteType} item.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 10.0),
                                    AnimatedSwitcher(
                                        switchInCurve: Curves.easeInExpo,
                                        switchOutCurve: Curves.easeOutExpo,
                                        duration: Duration(milliseconds: 400),
                                        transitionBuilder: (child, animation) {
                                          return ScaleTransition(
                                            scale: animation,
                                            child: child,
                                          );
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            child: Container(
                                                height: 60,
                                                width: 60,
                                                child: ClipOval(
                                                  child: Material(
                                                    color:
                                                        CityColors.primary_teal,
                                                    child: InkWell(
                                                      splashColor: Colors.black,
                                                      onTap: () async {
                                                        _scanBloc.add(
                                                            WasteItemImageTakenEvent(
                                                          _cameraController,
                                                          BlocProvider.of<
                                                                      AuthBloc>(
                                                                  context)
                                                              .currentUser,
                                                        ));
                                                      },
                                                      child: Icon(
                                                        Icons.camera,
                                                        color: Colors.white,
                                                        size: 40.0,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            )
                          : AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.bounceOut,
                              child: !_isUploadingImageSuccessful
                                  ? Card(
                                      key: Key("cardOneUpload"),
                                      child: Padding(
                                          child: CircularProgressIndicator(),
                                          padding: const EdgeInsets.all(20.0)),
                                      color: Colors.black12,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0))),
                                    )
                                  : Card(
                                      key: Key("cardTwoUpload"),
                                      child: Padding(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                color: CityColors.primary_teal,
                                                size: 30.0,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text("Nice picture!",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color:
                                                        CityColors.primary_teal,
                                                  ))
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(20.0)),
                                      color: Colors.black12,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0))),
                                    ),
                            )),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.black12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "You've scanned a " +
                                _scanBloc.currentCityScanQrCode.wasteType +
                                " bin.",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ])
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildThrowingScreen() {
    return Center(
      child: Text("Throwing"),
    );
  }
}
