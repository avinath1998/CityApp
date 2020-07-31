part of 'scan_bloc.dart';

@immutable
abstract class ScanState {}

class ScanInitial extends ScanState {}

//init camera
class CameraInitiailizedFailedState extends ScanState {
  final String errorMsg;
  CameraInitiailizedFailedState(this.errorMsg);
}

class CameraInitiailizedSucessState extends ScanState {
  final CameraController cameraController;
  CameraInitiailizedSucessState(this.cameraController);
}

//bin image tab

class BinImageUploadingState extends ScanState {
  final String filepath;

  BinImageUploadingState(this.filepath);
}

class BinImageSuccessState extends ScanState {}

class BinImageFailedUploadState extends ScanState {}

//waste item tab
class WasteItemImageTakenState extends ScanState {}

class WasteImageUploadingState extends ScanState {
  final String filepath;
  WasteImageUploadingState(this.filepath);
}

class WasteImageSuccessState extends ScanState {}

class WasteImageFailedUploadState extends ScanState {}

class FailedToTakeWasteImage extends ScanState {}

//winnings tab
class WinningScanStateState extends ScanState {
  final ScanWinnings scanWinnings;
  WinningScanStateState(this.scanWinnings);
}

class NoScanWinningsState extends ScanState {}

class FailedToFetchScanWinnings extends ScanState {
  final DataFetchException dataFetchException;

  FailedToFetchScanWinnings(this.dataFetchException);
}

//throwing tab
class DoneThrowingItemState extends ScanState {}

class UploadingDataState extends ScanState {}

class UploadDataSuccessState extends ScanState {}

class UploadDataFailedState extends ScanState {}
