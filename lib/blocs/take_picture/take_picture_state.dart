part of 'take_picture_bloc.dart';

abstract class TakePictureState extends Equatable {
  const TakePictureState();

  @override
  List<Object> get props => [];
}

class TakePictureInitial extends TakePictureState {
  @override
  List<Object> get props => [];
}

class CameraInitializeSuccessState extends TakePictureState {
  final CameraController cameraController;

  CameraInitializeSuccessState(this.cameraController);
}

class CameraInitializeFailedState extends TakePictureState {
  final Exception e;
  final String errorMsg;

  CameraInitializeFailedState(this.e, this.errorMsg);
}

class CameraPictureTakenSuccessState extends TakePictureState {
  final File image;

  CameraPictureTakenSuccessState(this.image);
}
