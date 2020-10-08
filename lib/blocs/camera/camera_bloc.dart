import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:citycollection/exceptions/no_camera_found_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

part 'camera_event.dart';
part 'camera_state.dart';
part 'camera_bloc.freezed.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(_Initial());

  CameraController _cameraController;
  final Logger logger = Logger("CameraBloc");
  @override
  Stream<CameraState> mapEventToState(
    CameraEvent event,
  ) async* {
    yield* event.when(
        dispose: () => _dispose(),
        started: () => _onStarted(),
        initialize: () => _initializeCamera(),
        takePicture: () => _takePicture());
  }

  Stream<CameraState> _dispose() async* {
    _cameraController.dispose();
    yield CameraState.disposed();
  }

  Stream<CameraState> _onStarted() async* {
    yield CameraState.initial();
  }

  Stream<CameraState> _initializeCamera() async* {
    try {
      CameraController cameraController = await _initCameraScanner();
      yield CameraState.initialized(cameraController);
    } on NoCameraFoundException catch (e) {
      yield CameraState.initializationFailed(e);
    } on CameraException catch (e) {
      yield CameraState.initializationFailed(e);
    }
  }

  Stream<CameraState> _takePicture() async* {
    try {
      String filePath = await _generateNewFilePath();
      await _cameraController.takePicture(filePath);

      yield CameraState.pictureTaken(File(filePath));
    } on CameraException catch (e, stacktrace) {
      logger.severe("Error with the camera: ${e.toString()}");
      logger.severe(stacktrace);
      yield CameraState.failedToTakePicture(e);
    } catch (e, stacktrace) {
      logger.severe("Error with the camera: ${e.toString()}");
      logger.severe(stacktrace);
      yield CameraState.failedToTakePicture(e);
    }
  }

  Future<CameraController> _initCameraScanner() async {
    List<CameraDescription> cameras = await availableCameras();
    if (cameras.length > 0) {
      CameraController _cameraController = CameraController(
          cameras[0], ResolutionPreset.low,
          enableAudio: false);
      await _cameraController.initialize();
      this._cameraController = _cameraController;
      return _cameraController;
    } else {
      throw NoCameraFoundException("No Camera Found!");
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
}
