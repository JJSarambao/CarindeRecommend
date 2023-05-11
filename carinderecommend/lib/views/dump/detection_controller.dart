import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:tflite/tflite.dart';

class DetectionController extends GetxController {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  final RxBool _isInitialized = RxBool(false);

  CameraController get cameraController =>
      _cameraController; // getter for camera widget
  bool get isInitialized => _isInitialized.value;

  @override
  void dispose() {
    _isInitialized.value = false;
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.bgra8888);
    _cameraController.initialize().then((_) {
      _isInitialized.value = true;
      _isInitialized.refresh();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            if (kDebugMode) {
              print('Camera cannot be access');
            }
            break;
          default:
            if (kDebugMode) {
              print('Some errors');
            }
            break;
        }
      }
    });
  }

  @override
  void onInit() {
    _initCamera();
    super.onInit();
  }
}
