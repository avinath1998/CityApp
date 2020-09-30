import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:citycollection/blocs/camera/camera_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/dialogs/ekva_alert_dialog.dart';
import 'package:citycollection/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';

class TakePictureScreen extends StatefulWidget {
  final String message;
  static const routeName = "TakePictureScreen";
  final Function(File image) onImageTaken;
  final Icon icon;
  const TakePictureScreen({Key key, this.message, this.onImageTaken, this.icon})
      : super(key: key);
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen>
    with TickerProviderStateMixin {
  File _image;
  CameraController _cameraController;
  CameraBloc _cameraBloc;
  final Logger logger = Logger("TakePictureScreenState");

  @override
  void initState() {
    super.initState();
    _cameraBloc = CameraBloc()..add(CameraEvent.started());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cameraBloc.add(CameraEvent.initialize());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cameraBloc.add(CameraEvent.dispose());
    _cameraBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      body: BlocListener(
        cubit: _cameraBloc,
        listener: (context, CameraState state) {
          state.when(
              initial: () {},
              disposed: () {},
              initialized: (CameraController controller) {
                setState(() {
                  _cameraController = controller;
                });
              },
              initializationFailed: (Exception e) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    child: EkvaAlertDialog(
                      message: "An error has occured, try again",
                      onOkPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop(e);
                      },
                    ));
              },
              pictureTaken: (File image) {
                setState(() {
                  _image = image;
                });
              },
              failedToTakePicture: (Exception e) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    child: EkvaAlertDialog(
                      message: "An error has occured, try again",
                      onOkPressed: () {
                        Navigator.of(context).pop(e);
                      },
                    ));
              });
        },
        child: _cameraController != null
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
                widget.icon != null
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: widget.icon,
                            ),
                            color: Colors.black12,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                        ))
                    : Container(),
                Align(
                    alignment: Alignment.center,
                    child: AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn,
                      child: _image != null
                          ? Image.file(
                              _image,
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
                          duration: Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          child: _image == null
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Take a picture",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          widget.message ??
                                              "Tap the button below.",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(color: Colors.white),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
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
                                                        _cameraBloc.add(
                                                            CameraEvent
                                                                .takePicture());
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
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Card(
                                  key: Key("cardOne"),
                                  color: Colors.black12,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Retake?",
                                            style: Theme.of(context)
                                                .textTheme
                                                .button
                                                .copyWith(
                                                  color:
                                                      CityColors.primary_teal,
                                                ),
                                            textAlign: TextAlign.start,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _image = null;
                                            });
                                          },
                                        ),
                                        RaisedButton(
                                          shape: Theme.of(context)
                                              .buttonTheme
                                              .shape,
                                          color: Theme.of(context).buttonColor,
                                          child: Text(
                                            "Continue",
                                            style: Theme.of(context)
                                                .textTheme
                                                .button
                                                .copyWith(color: Colors.white),
                                            textAlign: TextAlign.start,
                                          ),
                                          onPressed: () async {
                                            if (widget.onImageTaken != null) {
                                              await _cameraController.dispose();
                                              widget.onImageTaken(_image);
                                            } else {
                                              await _cameraController.dispose();
                                              Navigator.of(context).pop(_image);
                                            }
                                          },
                                        ),
                                        SizedBox(height: 10.0),
                                      ],
                                    ),
                                  ),
                                ),
                        ))),
              ])
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
