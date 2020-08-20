part of 'take_picture_bloc.dart';

abstract class TakePictureEvent extends Equatable {
  const TakePictureEvent();

  @override
  List<Object> get props => [];
}

class InitializeCameraEvent extends TakePictureEvent {}

class InitPictureTakeEvent extends TakePictureEvent {}
