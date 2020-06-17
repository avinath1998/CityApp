import 'package:camera/camera.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';

class ScanCamScreen extends StatefulWidget {
  @override
  ScanCamScreenState createState() => ScanCamScreenState();
}

class ScanCamScreenState extends State<ScanCamScreen> {
  CameraController controller;
  List<CameraDescription> cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "CityScan",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold))
          ]),
        ),
      ),
      body: _buildQRScannerTab(),
    );
  }

  Widget _buildQRScannerTab() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      _isCameraInitialized
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              child:
                                  Container(child: CameraPreview(controller)),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Take an image of your item.",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Container(
                  child: Divider(),
                  width: 30.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
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
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      color: CityColors.primary_green,
                      onPressed: () {},
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }

  void initializeCameras() async {
    print("Camera initail");
    List<CameraDescription> cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      setState(() {
        _isCameraInitialized = true;
        print("camera initialized");
      });
    });
  }
}
