import 'dart:io';

import 'package:camera/camera.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/bin_scan_steps/bin_scan_steps_bloc.dart';
import 'package:citycollection/blocs/camera_tab/camera_tab_bloc.dart';
import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/cityscan_qrcode.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:citycollection/screens/otp_verification_screen.dart';
import 'package:citycollection/screens/scan_tabs/camera_tab.dart';
import 'package:citycollection/screens/scan_tabs/throw_tab.dart';
import 'package:citycollection/screens/scan_tabs/winner_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:logging/logging.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  final Logger logger = Logger("ScanScreenState");
  ScanBloc _scanBloc;
  BinScanStepsBloc _binScanStepsBloc;

  TabController _tabController;
  CameraController _cameraController;
  CameraTabBloc _cameraTabBloc;

  String _binImageSrc;
  String _wasteImageSrc;

  @override
  void initState() {
    super.initState();
    _scanBloc = ScanBloc(GetIt.instance<DataRepository>());
    _binScanStepsBloc = BinScanStepsBloc(GetIt.instance<DataRepository>());
    _tabController = TabController(length: 4, vsync: this);
    // _scanBloc.add(InitializeCameraEvent());
    print(
        "LOGGING NAME: ${BlocProvider.of<AuthBloc>(context).currentUser.name}");
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
          create: (context) => _binScanStepsBloc,
          child: Container(
            child: BlocListener<BinScanStepsBloc, BinScanStepsState>(
                bloc: _binScanStepsBloc,
                listener: (context, BinScanStepsState state) {
                  logger.info(state);
                  if (state is BinScanStepChangedState) {
                    _tabController.animateTo(state.page,
                        duration: Duration(milliseconds: 300));
                  } else if (state is DisposalDataSavedState) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    logger.info(state.wonPrize);
                    if (state.wonPrize) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Center(
                              child: Material(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  width: 300.0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text("Congratulations on your prize!",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: CityColors.primary_teal,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      Icon(
                                        Icons.check,
                                        color: CityColors.primary_teal,
                                        size: 40.0,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Someone from our team will contact you shortly to send you your prize!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CityColors.primary_teal,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        color: CityColors.primary_teal,
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  } else if (state is DisposalDataLoadingState) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                  } else if (state is DisposalDataFailedState) {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "An error occured saving your disposal.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Stack(
                  children: <Widget>[
                    TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        CameraTab(
                          onImageUploaded: (val) {
                            _binScanStepsBloc.add(BinScanStepChangedEvent(1));
                            setState(() {
                              _binImageSrc = val;
                            });
                          },
                          onImageFailedUpload: () {
                            Fluttertoast.showToast(
                                msg: "An error occured, try again.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          },
                          stepIcon: FontAwesomeIcons.trashAlt,
                          stepString: "Step 1:",
                          titleCapture: "Capture Trash Bin",
                          descriptionCapture:
                              "Take a picture of the trash bin.",
                        ),
                        CameraTab(
                          onImageUploaded: (val) {
                            _binScanStepsBloc.add(BinScanStepChangedEvent(2));
                            setState(() {
                              _wasteImageSrc = val;
                            });
                          },
                          onImageFailedUpload: () {
                            Fluttertoast.showToast(
                                msg: "An error occured, try again.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          },
                          stepImage: Image.asset(
                            "assets/images/water.png",
                            color: Colors.white,
                          ),
                          stepString: "Step 2:",
                          titleCapture: "Capture Waste",
                          descriptionCapture: "Take a picture of your garbage.",
                        ),
                        ThrowingTab(
                          onContinueTapped: () {
                            _binScanStepsBloc.add(BinScanStepChangedEvent(3));
                            //logger.info(_wasteImageSrc);
                          },
                        ),
                        WinnerTab(
                          onRedeemed:
                              (ScanWinnings winnings, String phoneNumber) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0))),
                                      title: Text("Confirm Number",
                                          style: TextStyle(
                                            color: CityColors.primary_teal,
                                          )),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            "Confirm your phone number:",
                                          ),
                                          SizedBox(height: 5),
                                          Text(phoneNumber,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          child: Text("No",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          color: Colors.transparent,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          child: Text("Confirm"),
                                          color: CityColors.primary_teal,
                                          onPressed: () {
                                            _binScanStepsBloc.add(SaveBinEvent(
                                                _binImageSrc,
                                                _wasteImageSrc,
                                                BlocProvider.of<AuthBloc>(
                                                        context)
                                                    .currentUser,
                                                winnings,
                                                phoneNumber));
                                          },
                                        )
                                      ],
                                    ));

                            // _binScanStepsBloc.add(SaveBinEvent(
                            //     _binImageSrc,
                            //     _wasteImageSrc,
                            //     BlocProvider.of<AuthBloc>(context).currentUser,
                            //     winnings,
                            //     val));
                          },
                          onLose: () {
                            //occurs right when the user loses, no events are needed from the user
                            _binScanStepsBloc.add(SaveBinEvent(
                                _binImageSrc,
                                _wasteImageSrc,
                                BlocProvider.of<AuthBloc>(context).currentUser,
                                null,
                                null));
                          },
                          onFailedToGetWinnings: () {
                            Fluttertoast.showToast(
                                msg: "An error occured, try again.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          },
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
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: BlocProvider(
  //         create: (context) => _scanBloc,
  //         child: BlocListener<ScanBloc, ScanState>(
  //             bloc: _scanBloc,
  //             listener: (context, state) {
  //               //bin image tab
  //               if (state is CameraInitiailizedFailedState) {
  //                 showDialog(
  //                     context: context,
  //                     builder: (context) => AlertDialog(
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius:
  //                                   BorderRadius.all(Radius.circular(30.0))),
  //                           title: Text("Whoops!"),
  //                           content: Text(
  //                             "An error has occured with your camera, try again.",
  //                           ),
  //                           actions: <Widget>[
  //                             FlatButton(
  //                               child: Text("Close"),
  //                               onPressed: () {
  //                                 Navigator.of(context).pop();
  //                                 Navigator.of(context).pop();
  //                               },
  //                             )
  //                           ],
  //                         ));
  //                 //camera tab
  //               } else if (state is CameraInitiailizedSucessState) {
  //                 setState(() {
  //                   _cameraController = state.cameraController;
  //                   _isCameraInitialized = true;
  //                 });
  //               } else if (state is BinImageUploadingState) {
  //                 setState(() {
  //                   _isBinImageUploading = true;
  //                   _currentBinImageSrc = state.filepath;
  //                 });
  //               } else if (state is BinImageSuccessState) {
  //                 setState(() {
  //                   _isUploadingBinSuccessful = true;
  //                 });
  //                 Future.delayed(Duration(seconds: 2), () {
  //                   _tabController.animateTo(1,
  //                       duration: Duration(milliseconds: 300));
  //                 });
  //               } else if (state is BinImageFailedUploadState) {
  //                 setState(() {
  //                   _isUploadingBinSuccessful = false;
  //                 });
  //                 Navigator.of(context).pop();
  //                 Fluttertoast.showToast(
  //                     msg: "An error occured, try again.",
  //                     toastLength: Toast.LENGTH_SHORT,
  //                     gravity: ToastGravity.BOTTOM,
  //                     timeInSecForIosWeb: 1,
  //                     backgroundColor: Colors.red,
  //                     textColor: Colors.white,
  //                     fontSize: 16.0);
  //               } else if (state is WasteImageUploadingState) {
  //                 setState(() {
  //                   _isWasteImageUploading = true;
  //                   _currentImageSrc = state.filepath;
  //                 });
  //               } else if (state is WasteImageSuccessState) {
  //                 setState(() {
  //                   _isUploadingImageSuccessful = true;
  //                 });
  //                 Future.delayed(Duration(seconds: 2), () {
  //                   _tabController.animateTo(2,
  //                       duration: Duration(milliseconds: 300));
  //                   _cameraController.dispose();
  //                 });
  //               } else if (state is FailedToTakeWasteImage) {
  //                 Navigator.of(context).pop();
  //                 Fluttertoast.showToast(
  //                     msg: "An error occured, try again.",
  //                     toastLength: Toast.LENGTH_SHORT,
  //                     gravity: ToastGravity.BOTTOM,
  //                     timeInSecForIosWeb: 1,
  //                     backgroundColor: Colors.red,
  //                     textColor: Colors.white,
  //                     fontSize: 16.0);
  //               } else if (state is WasteImageFailedUploadState) {
  //                 Navigator.of(context).pop();
  //                 //throwing tab
  //               } else if (state is DoneThrowingItemState) {
  //                 _tabController.animateTo(3,
  //                     duration: Duration(milliseconds: 300));
  //                 Fluttertoast.showToast(
  //                     msg: "Thanks for your disposal!",
  //                     toastLength: Toast.LENGTH_SHORT,
  //                     gravity: ToastGravity.BOTTOM,
  //                     timeInSecForIosWeb: 1,
  //                     backgroundColor: CityColors.primary_teal,
  //                     textColor: Colors.white,
  //                     fontSize: 16.0);
  //                 //winnning tab
  //               } else if (state is WinningScanStateState) {
  //                 Future.delayed(Duration(seconds: 4), () {
  //                   setState(() {
  //                     _currentScanWinnings = state.scanWinnings;
  //                     _isScanWinningsWaiting = false;
  //                   });
  //                 });
  //                 _scanBloc.add(UploadDisposalDataEvent(
  //                   BlocProvider.of<AuthBloc>(context).currentUser,
  //                 ));
  //               } else if (state is NoScanWinningsState) {
  //                 Future.delayed(Duration(seconds: 4), () {
  //                   setState(() {
  //                     _isScanWinningsWaiting = false;
  //                   });
  //                 });
  //                 _scanBloc.add(UploadDisposalDataEvent(
  //                   BlocProvider.of<AuthBloc>(context).currentUser,
  //                 ));
  //               } else if (state is UploadingDataState) {
  //                 logger.info("Uploading the disposal data state");
  //               } else if (state is UploadDataFailedState) {
  //                 Fluttertoast.showToast(
  //                     msg: "Failed saving your disposal :(",
  //                     toastLength: Toast.LENGTH_SHORT,
  //                     gravity: ToastGravity.BOTTOM,
  //                     timeInSecForIosWeb: 1,
  //                     backgroundColor: Colors.red,
  //                     textColor: Colors.white,
  //                     fontSize: 16.0);
  //                 Navigator.of(context).pop();
  //               } else if (state is UploadDataSuccessState) {
  //                 logger.info("Uploaded disposal data state");
  //               }
  //             },
  //             child: Stack(
  //               children: <Widget>[
  //                 TabBarView(
  //                   controller: _tabController,
  //                   physics: NeverScrollableScrollPhysics(),
  //                   children: <Widget>[
  //                     CameraTab(
  //                       context: context,
  //                       isCameraInitialized: _isCameraInitialized,
  //                       cameraController: _cameraController,
  //                       currentImageSrc: _currentBinImageSrc,
  //                       isWasteImageUploading: _isBinImageUploading,
  //                       isUploadingImageSuccessful: _isUploadingBinSuccessful,
  //                       onImageTaken: () {
  //                         _scanBloc.add(BinImageTakenEvent(
  //                           _cameraController,
  //                           BlocProvider.of<AuthBloc>(context).currentUser,
  //                         ));
  //                       },
  //                     ),
  //                     CameraTab(
  //                       context: context,
  //                       isCameraInitialized: _isCameraInitialized,
  //                       cameraController: _cameraController,
  //                       currentImageSrc: _currentImageSrc,
  //                       isWasteImageUploading: _isWasteImageUploading,
  //                       isUploadingImageSuccessful: _isUploadingImageSuccessful,
  //                       onImageTaken: () {
  //                         _scanBloc.add(WasteItemImageTakenEvent(
  //                           _cameraController,
  //                           BlocProvider.of<AuthBloc>(context).currentUser,
  //                         ));
  //                       },
  //                     ),
  //                     ThrowingTab(),
  //                     WinnerTab(
  //                       scanWinnings: _currentScanWinnings,
  //                       isWaiting: _isScanWinningsWaiting,
  //                     ),
  //                   ],
  //                 ),
  //                 Align(
  //                   alignment: Alignment.topLeft,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Container(
  //                       margin: const EdgeInsets.all(10.0),
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Icon(
  //                         Icons.arrow_back,
  //                         color: CityColors.primary_teal,
  //                         size: 40,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             )),
  //       ),
  //     ),
  //   );
  // }
}
