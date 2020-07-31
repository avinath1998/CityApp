part of 'camera_tab_bloc.dart';

abstract class CameraTabState extends Equatable {
  const CameraTabState();
}

class CameraTabInitial extends CameraTabState {
  @override
  List<Object> get props => [];
}

class CameraInitiailizeFailedState extends CameraTabState {
  final String errorMsg;
  CameraInitiailizeFailedState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class CameraInitiailizeSucessState extends CameraTabState {
  final CameraController cameraController;
  CameraInitiailizeSucessState(this.cameraController);

  @override
  List<Object> get props => [cameraController];
}

class CameraInitiailizedLoadingState extends CameraTabState {
  @override
  List<Object> get props => [];
}

class UploadImageSuccessState extends CameraTabState {
  final String filepath;

  UploadImageSuccessState(this.filepath);
  @override
  List<Object> get props => [filepath];
}

class UploadImageFailedState extends CameraTabState {
  final String errorMsg;
  UploadImageFailedState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class UploadImageLoadingState extends CameraTabState {
  final String filepath;
  UploadImageLoadingState(this.filepath);

  @override
  List<Object> get props => [];
}
