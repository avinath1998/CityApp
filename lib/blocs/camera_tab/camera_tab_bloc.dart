import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

part 'camera_tab_event.dart';
part 'camera_tab_state.dart';

class CameraTabBloc extends Bloc<CameraTabEvent, CameraTabState> {
  final Logger logger = Logger("CameraTabBloc");
  final DataRepository _dataRepository;
  CameraController _cameraController;
  final CurrentUser _currentUser;

  CameraTabBloc(this._dataRepository, this._currentUser);

  @override
  CameraTabState get initialState => CameraTabInitial();

  @override
  Stream<CameraTabState> mapEventToState(
    CameraTabEvent event,
  ) async* {
    if (event is InitCameraEvent) {
      yield* _initCamera();
    } else if (event is TakePictureEvent) {
      yield* _takePicture();
    } else if (event is DisposeCameraController) {
      _cameraController.dispose();
    }
  }

  Stream<CameraTabState> _initCamera() async* {
    try {
      logger.info("Initializing Camera");
      yield CameraInitiailizedLoadingState();
      CameraController _cameraControllerInit = await _initCameraScanner();
      _cameraController = _cameraControllerInit;
      yield CameraInitiailizeSucessState(_cameraController);
      logger.info("Initialized Camera Successfully");
    } catch (e) {
      logger.severe("Failed to initialize camera");
      logger.severe(e.toString());
      yield CameraInitiailizeFailedState(e.toString());
    }
  }

  Stream<CameraTabState> _takePicture() async* {
    logger.info("taking bin picture");
    try {
      String filePath = await _generateNewFilePath();
      await _cameraController.takePicture(filePath);
      Uint8List image = await File(filePath)
          .readAsBytes(); //throws an unsupported error if image not found
      yield UploadImageLoadingState(filePath);
      String binImageRef =
          await _dataRepository.uploadBinImage(_currentUser, image);
      yield UploadImageSuccessState(binImageRef);
    } on CameraException catch (e, stacktrace) {
      logger.severe("Error with the camera: ${e.description}");
      logger.severe(stacktrace);
      yield UploadImageFailedState(e.toString());
    } catch (e, stacktrace) {
      logger.severe("Error taking image ${e.description}");
      logger.severe(stacktrace);
      yield UploadImageFailedState(e.toString());
    }
  }

  Future<CameraController> _initCameraScanner() async {
    List<CameraDescription> cameras = await availableCameras();
    CameraController _cameraController = CameraController(
        cameras[0], ResolutionPreset.medium,
        enableAudio: false);
    await _cameraController.initialize();
    print("Camera initialized");
    return _cameraController;
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
