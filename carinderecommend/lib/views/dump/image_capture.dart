// import 'dart:io';
// import 'package:carinderecommend/detection_controller.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class CaptureImage extends GetView<DetectionController> {
//   CaptureImage({super.key});

//   final String apiUrl = "https://04e4-180-190-75-48.ngrok-free.app/upload";
//   File? _image;

//   Future getImage() async {
//     final image = ImagePicker().getImage(source: ImageSource.camera);
//     _image = File(image!.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 30,
//       child: GestureDetector(
//         onTap: null,
//         child: Container(
//           height: 75,
//           width: 75,
//           padding: const EdgeInsets.all(5),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.transparent,
//             border: Border.all(color: Colors.white, width: 5),
//           ),
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//             child: const Center(
//               child: Icon(
//                 Icons.camera,
//                 size: 40,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
