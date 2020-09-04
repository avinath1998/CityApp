import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:citycollection/exceptions/NoCameraFoundException.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

part 'take_picture_event.dart';
part 'take_picture_state.dart';

class TakePictureBloc extends Bloc<TakePictureEvent, TakePictureState> {
  final Logger logger = Logger("TakePictureBloc");
  CameraController _cameraController;

  TakePictureBloc() : super(TakePictureInitial());

  @override
  Future<void> close() {
    if (_cameraController != null) {
      _cameraController.dispose();
      _cameraController = null;
    }
    logger.info("Disposing of Camera");
    return super.close();
  }

  @override
  Stream<TakePictureState> mapEventToState(
    TakePictureEvent event,
  ) async* {
    if (event is InitializeCameraEvent) {
      yield* _initCamera();
    } else if (event is InitPictureTakeEvent) {
      yield* _takePicture();
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

  Stream<TakePictureState> _takePicture() async* {
    logger.info("Taking picture");
    if (_cameraController != null) {
      String filePath = await _generateNewFilePath();
      await _cameraController.takePicture(filePath);
      File file = File(filePath);
      yield (CameraPictureTakenSuccessState(file));
      yield (TakePictureInitial());

      logger.info("Done taking picture");
    } else {
      logger.severe("Camera Controller is null");
    }
  }

  Stream<TakePictureState> _initCamera() async* {
    logger.info("Initializing Camera");
    if (_cameraController == null) {
      try {
        List<CameraDescription> cameras = await availableCameras();
        if (cameras.length > 0) {
          _cameraController =
              CameraController(cameras[0], ResolutionPreset.medium);
          await _cameraController.initialize();
          logger.info("Camera is initialized successfully.");
          yield CameraInitializeSuccessState(_cameraController);
        } else {
          logger.severe("No Camera Found");
          yield CameraInitializeFailedState(
              NoCameraFoundException("No camera found"), "No camera found");
        }
      } on CameraException catch (e, stk) {
        logger.severe(e.description);
        logger.severe(stk.toString());
        yield CameraInitializeFailedState(e, e.description);
      }
    } else {
      yield CameraInitializeSuccessState(_cameraController);
    }
  }
}
