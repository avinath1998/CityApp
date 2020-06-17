part of 'scan_bloc.dart';

@immutable
abstract class ScanState {}

class ScanInitial extends ScanState {}

class CorrectQrScanned extends ScanState {
  final CityScanQrCode cityScanQrCode;
  final CameraController cameraController;

  CorrectQrScanned(this.cityScanQrCode, this.cameraController);
}

class CameraInitiailizedFailed extends ScanState {}

class ValidImageTakenState extends ScanState {}

class InvalidImageTakenState extends ScanState {}

class ErrorScanValidationState extends ScanState {
  final DataFetchException _dataFetchException;
  ErrorScanValidationState(this._dataFetchException);
}
