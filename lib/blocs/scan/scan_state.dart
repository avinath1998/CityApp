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
  final Exception e;
  ErrorScanValidationState(this.e);
}

class WasteItemImageTakenState extends ScanState {}

class WasteImageUploadingState extends ScanState {
  final String filepath;
  WasteImageUploadingState(this.filepath);
}

class WasteImageSuccessState extends ScanState {}

class WasteImageFailedUploadState extends ScanState {}

class FailedToTakeWasteImage extends ScanState {}

class WinningScanStateState extends ScanState {
  final ScanWinnings scanWinnings;
  WinningScanStateState(this.scanWinnings);
}

class NoScanWinningsState extends ScanState {}

class FailedToFetchScanWinnings extends ScanState {
  final DataFetchException dataFetchException;

  FailedToFetchScanWinnings(this.dataFetchException);
}

class DoneThrowingItemState extends ScanState {}
