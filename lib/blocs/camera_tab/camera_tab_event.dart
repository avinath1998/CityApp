part of 'camera_tab_bloc.dart';

abstract class CameraTabEvent extends Equatable {
  const CameraTabEvent();
}

class InitCameraEvent extends CameraTabEvent {
  @override
  List<Object> get props => [];
}

class TakePictureEvent extends CameraTabEvent {
  @override
  List<Object> get props => [];
}

class DisposeCameraController extends CameraTabEvent {
  @override
  List<Object> get props => [];
}
