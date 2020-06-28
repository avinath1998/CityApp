import 'dart:io';

import 'package:camera/camera.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraTab extends StatefulWidget {
  const CameraTab(
      {Key key,
      @required this.context,
      @required bool isCameraInitialized,
      @required CameraController cameraController,
      @required String currentImageSrc,
      @required bool isWasteImageUploading,
      @required bool isUploadingImageSuccessful})
      : _isCameraInitialized = isCameraInitialized,
        _cameraController = cameraController,
        _currentImageSrc = currentImageSrc,
        _isWasteImageUploading = isWasteImageUploading,
        _isUploadingImageSuccessful = isUploadingImageSuccessful,
        super(key: key);

  final BuildContext context;
  final bool _isCameraInitialized;
  final CameraController _cameraController;
  final String _currentImageSrc;
  final bool _isWasteImageUploading;
  final bool _isUploadingImageSuccessful;

  @override
  _CameraTabState createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> with TickerProviderStateMixin {
  AnimationController _picCardController;

  @override
  void initState() {
    super.initState();
    _picCardController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _picCardController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      child: widget._isCameraInitialized
          ? Stack(children: <Widget>[
              Center(
                child: Transform.scale(
                  scale:
                      widget._cameraController.value.aspectRatio / deviceRatio,
                  child: AspectRatio(
                    aspectRatio: widget._cameraController.value.aspectRatio,
                    child: CameraPreview(widget._cameraController),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceOut,
                    child: widget._currentImageSrc != null
                        ? Image.file(
                            File(widget._currentImageSrc),
                            frameBuilder:
                                (context, child, frame, wasSyncholoaded) {
                              return Container(
                                margin: const EdgeInsets.all(30.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: ClipRRect(
                                    child: child,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                              );
                            },
                          )
                        : Container(
                            height: 1,
                            width: 1,
                          ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: AnimatedSize(
                      vsync: this,
                      curve: Curves.easeOut,
                      duration: Duration(milliseconds: 400),
                      child: !widget._isWasteImageUploading
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
                                      "Take a picture of your ${BlocProvider.of<ScanBloc>(context).currentCityScanQrCode.wasteType} item.",
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
                                                        BlocProvider.of<
                                                                    ScanBloc>(
                                                                context)
                                                            .add(
                                                                WasteItemImageTakenEvent(
                                                          widget
                                                              ._cameraController,
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
                              curve: Curves.easeOut,
                              child: !widget._isUploadingImageSuccessful
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
                                BlocProvider.of<ScanBloc>(context)
                                    .currentCityScanQrCode
                                    .wasteType +
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
}
