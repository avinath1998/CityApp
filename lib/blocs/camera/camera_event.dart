part of 'camera_bloc.dart';

@freezed
abstract class CameraEvent with _$CameraEvent {
  const factory CameraEvent.started() = _Started;
  const factory CameraEvent.initialize() = _Initialize;
  const factory CameraEvent.takePicture() = _TakePicture;
  const factory CameraEvent.dispose() = _Dispose;
}
