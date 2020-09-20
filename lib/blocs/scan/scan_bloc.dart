import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:citycollection/exceptions/data_fetch_exception.dart';
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
  QRViewController _controller;
  StreamSubscription sub;
  CityScanQrCode currentCityScanQrCode;

  ScanBloc(this._dataRepository) : super(ScanInitial());

  @override
  Stream<ScanState> mapEventToState(
    ScanEvent event,
  ) async* {
    if (event is QRViewCreatedEvent) {
      yield* _initQRScanner(event._controller);
    } else if (event is QRCodeReceived) {
      yield* _qrCodeReceived(event._cityScanQrCode);
    } else if (event is WasteItemImageTakenEvent) {
      yield* _takeWastePicture(event.cameraController, event.user);
    } else if (event is FailedQRCodeVerificationEvent) {
      yield ErrorScanValidationState(event.e);
    } else if (event is CheckWinningsEvent) {
      yield* _checkWinninges(event.currentUser);
    } else if (event is DoneThrowingItemEvent) {
      yield DoneThrowingItemState();
    }
  }

  Stream<ScanState> _qrCodeReceived(CityScanQrCode code) async* {
    try {
      CameraController _cameraController = await _initCameraScanner();
      yield (CorrectQrScanned(code, _cameraController));
    } on CameraException catch (e, stacktrace) {
      logger.severe(e);
      logger.severe(stacktrace);
      yield (CameraInitiailizedFailed());
    }
  }

  Stream<ScanState> _initQRScanner(QRViewController controller) async* {
    print("Initializing QR Code");
    sub = controller.scannedDataStream.listen((scanData) async {
      try {
        final Map<String, dynamic> data = json.decode(scanData);
        if (data.containsKey("type")) {
          if (data["type"] == _scanKey) {
            CityScanQrCode code =
                CityScanQrCode.fromJson(json.decode(scanData));
            currentCityScanQrCode = code;
            add(QRCodeReceived(code));
            sub.cancel();
            controller.dispose();
            return;
          }
        }
        sub.cancel();
        controller.dispose();
        add(FailedQRCodeVerificationEvent(Exception("Invalid QR Code")));
      } catch (e, stacktrace) {
        logger.severe(e);
        logger.severe(stacktrace);
        sub.cancel();
        controller.dispose();
        add(FailedQRCodeVerificationEvent(e));
      }
    });
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

  Stream<ScanState> _takeWastePicture(
      CameraController cameraController, CurrentUser user) async* {
    logger.info("taking waste picture");
    try {
      String filePath = await _generateNewFilePath();
      await cameraController.takePicture(filePath);
      Uint8List image = await File(filePath)
          .readAsBytes(); //throws an unsupported error if image not found
      yield WasteImageUploadingState(filePath);
      await _dataRepository.uploadWasteImage(user, image);
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

  @override
  Future<void> close() {
    _controller?.dispose();
    sub?.cancel();

    return super.close();
  }
}
