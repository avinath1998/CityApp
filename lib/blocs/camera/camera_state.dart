part of 'camera_bloc.dart';

@freezed
abstract class CameraState with _$CameraState {
  const factory CameraState.initial() = _Initial;

  const factory CameraState.initialized(CameraController cameraController) =
      _Initialized;

  const factory CameraState.initializationFailed(Exception e) =
      _InitializationFailed;

  const factory CameraState.pictureTaken(File image) = _PictureTaken;

  const factory CameraState.failedToTakePicture(Exception e) =
      _FailedToTakePicture;

  const factory CameraState.disposed() = _Disposed;
}
