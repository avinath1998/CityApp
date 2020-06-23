part of 'scan_bloc.dart';

@immutable
abstract class ScanEvent {}

class ScannedEvent extends ScanEvent {}

class QRViewCreatedEvent extends ScanEvent {
  final QRViewController _controller;
  QRViewCreatedEvent(this._controller);
}

class QRCodeReceived extends ScanEvent {
  final CityScanQrCode _cityScanQrCode;
  QRCodeReceived(this._cityScanQrCode);
}

class WasteItemImageTakenEvent extends ScanEvent {
  final CameraController cameraController;
  final CurrentUser user;
  WasteItemImageTakenEvent(this.cameraController, this.user);
}
