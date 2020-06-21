import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/models/cityscan_qrcode.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
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

  ScanBloc(this._dataRepository);

  @override
  ScanState get initialState => ScanInitial();

  @override
  Stream<ScanState> mapEventToState(
    ScanEvent event,
  ) async* {
    if (event is QRViewCreatedEvent) {
      yield* _initQRScanner(event._controller);
    } else if (event is QRCodeReceived) {
      yield* _qrCodeReceived(event._cityScanQrCode);
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
      final Map<String, dynamic> data = json.decode(scanData);
      if (data.containsKey("type")) {
        if (data["type"] == _scanKey) {
          CityScanQrCode code = CityScanQrCode.fromJson(json.decode(scanData));
          currentCityScanQrCode = code;
          add(QRCodeReceived(code));
          sub.cancel();
          controller.dispose();
        }
      }
    });
  }

  Future<CameraController> _initCameraScanner() async {
    print("Camera initial");
    List<CameraDescription> cameras = await availableCameras();
    CameraController _cameraController =
        CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    print("Camera initialized");
    return _cameraController;
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    sub?.cancel();

    return super.close();
  }
}
