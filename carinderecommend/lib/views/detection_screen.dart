import 'package:camera/camera.dart';
import 'package:carinderecommend/detection_controller.dart';
import 'package:carinderecommend/views/image_capture.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        DetectionViewer(),
        CaptureImage(),
      ],
    );
  }
}

class DetectionViewer extends GetView<DetectionController> {
  const DetectionViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DetectionController>(builder: (controller) {
      if (!controller.isInitialized) {
        if (kDebugMode) {
          print('not utilizing camera');
        }
        return Container();
      }
      return SizedBox(
          height: Get.height,
          width: Get.width,
          child: CameraPreview(controller.cameraController));
    });
  }
}
