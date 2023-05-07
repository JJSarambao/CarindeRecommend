import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CapturedImagePage extends StatelessWidget {
  final XFile image;

  const CapturedImagePage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Image.file(
          File(image.path),
          height: screenHeight * 0.8,
        ),
      ),
    );
  }
}
