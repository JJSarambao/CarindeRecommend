// import 'dart:convert';

import 'package:carinderecommend/detection_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

class CaptureImage extends GetView<DetectionController> {
  const CaptureImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      child: GestureDetector(
        onTap: (() {
          // Debugging purposes:
          if (kDebugMode) {
            print("Capture Button tapped!");
          }

          // onTap of Capture button will perform HTTP call to the
          // Hugging Face API server
        }),
        child: Container(
          height: 75,
          width: 75,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 5),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.camera,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<Map> imageDetection(String imageBase64) async {
  //   final response = await http.post(
  //     Uri.parse("https://huggingface.co/spaces/eskayML/object_detection_system", headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8'
  //     },
  //     body: jsonEncode(<String, List<dynamic>>{
  //       'data': [imageBase64]
  //     }))
  //   )
  // }

}
