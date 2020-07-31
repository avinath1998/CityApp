import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/models/cityscan_qrcode.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final String _scanKey = "CityScanBin";
  final DataRepository _dataRepository;
  final Logger logger = Logger("ScanBloc");
  String _currentBinImage;
  String _currentWasteImage;
  ScanWinnings _currentScanWinnings;
  String _currentScanDataId;

  QRViewController _controller;
  StreamSubscription sub;
  CityScanQrCode currentCityScanQrCode;

  ScanBloc(this._dataRepository);

  @override
  ScanState get initialState => ScanInitial();

  @override
  Stream<ScanState> mapEventToState(
    ScanEvent event,
  ) async* {
    if (event is InitializeCameraEvent) {
      yield* _initCameraController();
    } else if (event is WasteItemImageTakenEvent) {
      yield* _takeWastePicture(event.cameraController, event.user);
    } else if (event is CheckWinningsEvent) {
      yield* _checkWinninges(event.currentUser);
    } else if (event is DoneThrowingItemEvent) {
      yield DoneThrowingItemState();
    } else if (event is BinImageTakenEvent) {
      yield* _takeBinPicture(event.cameraController, event.user);
    } else if (event is UploadDisposalDataEvent) {
      yield* _saveDisposalData(event.currentUser);
    }
  }

  Stream<ScanState> _initCameraController() async* {
    try {
      CameraController _cameraController = await _initCameraScanner();
      yield (CameraInitiailizedSucessState(_cameraController));
    } on CameraException catch (e, stacktrace) {
      logger.severe(e);
      logger.severe(stacktrace);
      yield (CameraInitiailizedFailedState(e.toString()));
    }
  }

  Future<CameraController> _initCameraScanner() async {
    print("Camera initial");
    List<CameraDescription> cameras = await availableCameras();
    CameraController _cameraController = CameraController(
        cameras[0], ResolutionPreset.medium,
        enableAudio: false);
    await _cameraController.initialize();
    print("Camera initialized");
    return _cameraController;
  }

  Stream<ScanState> _takeBinPicture(
      CameraController cameraController, CurrentUser user) async* {
    logger.info("taking bin picture");
    try {
      String filePath = await _generateNewFilePath();
      await cameraController.takePicture(filePath);
      Uint8List image = await File(filePath)
          .readAsBytes(); //throws an unsupported error if image not found
      yield BinImageUploadingState(filePath);
      String binImageRef = await _dataRepository.uploadBinImage(user, image);
      _currentBinImage = binImageRef;
      yield BinImageSuccessState();
    } on CameraException catch (e, stacktrace) {
      logger.severe("Error with the camera: ${e.description}");
      logger.severe(stacktrace);
      yield BinImageFailedUploadState();
    } catch (e, stacktrace) {
      logger.severe("Error taking image ${e.description}");
      logger.severe(stacktrace);
      yield BinImageFailedUploadState();
    }
  }

  Stream<ScanState> _takeWastePicture(
      CameraController cameraController, CurrentUser user) async* {
    logger.info("taking waste picture");
    try {
      String filePath = await _generateNewFilePath();
      await cameraController.takePicture(filePath);
      Uint8List image = await File(filePath)
          .readAsBytes(); //throws an unsupported error if image not found
      yield WasteImageUploadingState(filePath);
      String wasteImageRef =
          await _dataRepository.uploadWasteImage(user, image);
      _currentWasteImage = wasteImageRef;
      yield WasteImageSuccessState();
    } on CameraException catch (e, stacktrace) {
      logger.severe("Error with the camera: ${e.description}");
      logger.severe(stacktrace);
      yield FailedToTakeWasteImage();
    } catch (e, stacktrace) {
      logger.severe("Error taking image ${e.description}");
      logger.severe(stacktrace);
      yield FailedToTakeWasteImage();
    }
  }

  Future<String> _generateNewFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dirPath = '${appDocDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${DateTime.now().toIso8601String()}.jpg';
    logger.info(filePath);
    return filePath;
  }

  Stream<ScanState> _checkWinninges(CurrentUser user) async* {
    logger.info("Checking Winnings");
    try {
      ScanWinnings winnings = await _dataRepository.fetchScanWinnings(user);
      _currentScanWinnings = winnings;
      if (winnings == null) {
        logger.info("No winnings fetched.");
        yield (NoScanWinningsState());
      } else {
        logger.info("Winner winner chicken dinner!!");
        logger.info("Winnings ID: ${winnings.id}, amount ${winnings.winnings}");
        yield (WinningScanStateState(winnings));
      }
    } on DataFetchException catch (e) {
      yield (FailedToFetchScanWinnings(e));
    }
  }

  Stream<ScanState> _saveDisposalData(CurrentUser user) async* {
    yield UploadingDataState();
    if (_currentWasteImage != null && _currentBinImage != null) {
      try {
        // String ref = await _dataRepository.saveDisposalData(
        //     user, _currentBinImage, _currentWasteImage, _currentScanWinnings);
        // _currentScanDataId = ref;
        // logger.info("Saved Data into $ref");
        yield UploadDataSuccessState();
      } catch (e) {
        logger.severe(e.toString());
        yield UploadDataFailedState();
      }
    } else {
      yield UploadDataFailedState();
    }
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    sub?.cancel();

    return super.close();
  }
}
