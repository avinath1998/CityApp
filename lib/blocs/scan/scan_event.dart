part of 'scan_bloc.dart';

@immutable
abstract class ScanEvent {}

class ScannedEvent extends ScanEvent {}

class InitializeCameraEvent extends ScanEvent {}

class BinImageTakenEvent extends ScanEvent {
  final CameraController cameraController;
  final CurrentUser user;
  BinImageTakenEvent(this.cameraController, this.user);
}

class WasteItemImageTakenEvent extends ScanEvent {
  final CameraController cameraController;
  final CurrentUser user;
  WasteItemImageTakenEvent(this.cameraController, this.user);
}

class CheckWinningsEvent extends ScanEvent {
  final CurrentUser currentUser;
  CheckWinningsEvent(this.currentUser);
}

class DoneThrowingItemEvent extends ScanEvent {}

class UploadDisposalDataEvent extends ScanEvent {
  final CurrentUser currentUser;
  UploadDisposalDataEvent(this.currentUser);
}
