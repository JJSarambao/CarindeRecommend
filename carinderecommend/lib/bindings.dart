import 'package:carinderecommend/detection_controller.dart';
import 'package:get/instance_manager.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetectionController>(() => DetectionController());
  }
}
