import 'dart:io';

import 'package:camera/camera.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/camera_tab/camera_tab_bloc.dart';
import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class CameraTab extends StatefulWidget {
  final Function(String) onImageUploaded;
  final Function onImageFailedUpload;
  final IconData stepIcon;
  final Image stepImage;
  final String stepString;
  final String titleCapture;
  final String descriptionCapture;
  const CameraTab(
      {Key key,
      this.onImageUploaded,
      this.onImageFailedUpload,
      this.stepIcon,
      this.stepString,
      this.titleCapture,
      this.descriptionCapture,
      this.stepImage})
      : super(key: key);

  @override
  _CameraTabState createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> with TickerProviderStateMixin {
  AnimationController _picCardController;
  CameraTabBloc _cameraTabBloc;
  bool _isCameraInitialized = false;
  CameraController _cameraController;
  String _currentImageSrc;
  bool _isWasteImageUploading = false;
  bool _isUploadingImageSuccessful = false;

  @override
  void initState() {
    super.initState();

    _cameraTabBloc = CameraTabBloc(GetIt.instance<DataRepository>(),
        BlocProvider.of<AuthBloc>(context).currentUser);

    _cameraTabBloc.add(InitCameraEvent());
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
    return BlocListener(
      bloc: _cameraTabBloc,
      listener: (context, state) {
        if (state is CameraInitiailizeFailedState) {
          widget.onImageFailedUpload();
        } else if (state is CameraInitiailizeSucessState) {
          setState(() {
            _isCameraInitialized = true;
            _cameraController = state.cameraController;
          });
        } else if (state is CameraInitiailizedLoadingState) {
          setState(() {
            _isCameraInitialized = false;
          });
        } else if (state is UploadImageSuccessState) {
          widget.onImageUploaded(state.filepath);
          _cameraController.dispose();
        } else if (state is UploadImageFailedState) {
          widget.onImageFailedUpload();
        } else if (state is UploadImageLoadingState) {
          setState(() {
            _currentImageSrc = state.filepath;
            _isWasteImageUploading = true;
          });
        }
      },
      child: AnimatedSwitcher(
        switchInCurve: Curves.easeInExpo,
        switchOutCurve: Curves.easeOutExpo,
        duration: Duration(milliseconds: 400),
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
                Align(
                    alignment: Alignment.center,
                    child: AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.bounceOut,
                      child: _currentImageSrc != null
                          ? Image.file(
                              File(_currentImageSrc),
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
                        child: !_isWasteImageUploading
                            ? Card(
                                key: Key("cardOne"),
                                color: Colors.black12,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.titleCapture,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        widget.descriptionCapture,
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
                                          transitionBuilder:
                                              (child, animation) {
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
                                                      color: CityColors
                                                          .primary_teal,
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.black,
                                                        onTap: () async {
                                                          _cameraTabBloc.add(
                                                              TakePictureEvent());
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
                                curve: Curves.elasticOut,
                                child: !_isUploadingImageSuccessful
                                    ? Card(
                                        key: Key("cardOneUpload"),
                                        child: Padding(
                                            child: CircularProgressIndicator(),
                                            padding:
                                                const EdgeInsets.all(20.0)),
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
                                                  color:
                                                      CityColors.primary_teal,
                                                  size: 30.0,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text("Nice picture!",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: CityColors
                                                          .primary_teal,
                                                    ))
                                              ],
                                            ),
                                            padding:
                                                const EdgeInsets.all(20.0)),
                                        color: Colors.black12,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                      ),
                              )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              widget.stepString,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.0,
                              width: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                widget.stepImage != null
                                    ? Image.asset(
                                        "assets/images/water.png",
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        widget.stepIcon,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ])
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
