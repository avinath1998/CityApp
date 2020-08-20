import 'package:camera/camera.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tab_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:citycollection/blocs/take_picture/take_picture_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'me_tab.dart';

class TakePictureTab extends StatefulWidget {
  final ScrollController scrollController;

  const TakePictureTab({Key key, this.scrollController}) : super(key: key);
  @override
  _TakePictureTabState createState() => _TakePictureTabState();
}

class _TakePictureTabState extends State<TakePictureTab> {
  TakePictureBloc _bloc;
  bool _isCameraInitialized = false;
  String _cameraError;
  CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _bloc = TakePictureBloc();
    _bloc.add(InitializeCameraEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: BlocListener<TakePictureBloc, TakePictureState>(
                  bloc: _bloc,
                  listener: (context, TakePictureState state) {
                    if (state is CameraInitializeSuccessState) {
                      setState(() {
                        _cameraController = state.cameraController;
                      });
                    } else if (state is CameraInitializeFailedState) {
                      setState(() {
                        _cameraError = "Could not initialize camera";
                      });
                    } else if (state is CameraPictureTakenSuccessState) {}
                  },
                  child: _cameraController != null
                      ? Column(
                          children: [
                            AspectRatio(
                              aspectRatio: _cameraController.value.aspectRatio,
                              child: CameraPreview(_cameraController),
                            ),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    "Take a picture of the garbage bin.",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  RaisedButton(
                                    onPressed: () {},
                                    color: CityColors.primary_teal,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: Text(
                                      "Capture",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
