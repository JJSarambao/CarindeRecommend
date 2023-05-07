import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'bounding_box.dart';

class CapturedImagePage extends StatefulWidget {
  final XFile image;
  const CapturedImagePage({required this.image, Key? key}) : super(key: key);

  @override
  _CapturedImagePageState createState() {
    return _CapturedImagePageState();
  }
}

class _CapturedImagePageState extends State<CapturedImagePage> {
  List<dynamic>? _recognitions;
  late double _imageWidth;
  late double _imageHeight;

  @override
  void initState() {
    super.initState();
    _getImageDimensions();
    _detectObjects();
  }

  Future<void> _getImageDimensions() async {
    final bytes = await widget.image.readAsBytes();
    final image = img.decodeImage(bytes);
    if (mounted) {
      setState(() {
        _imageWidth = image?.width.toDouble() ?? 0;
        _imageHeight = image?.height.toDouble() ?? 0;
      });
    }
  }

  Future<void> _detectObjects() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt",
      );
      print(res);

      final recognitions = await Tflite.detectObjectOnImage(
        path: widget.image.path,
        // model: "SSDMobileNet",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4,
        numResultsPerClass: 1,
      );

      // print(recognitions);

      setState(() {
        _recognitions = recognitions;
      });
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Captured Image"),
        ),
        body: _recognitions == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                Image.file(File(widget.image.path)),
                BoundingBox(
                  results: _recognitions!,
                  previewH: _imageHeight,
                  previewW: _imageWidth,
                  screenH: MediaQuery.of(context).size.height,
                  screenW: MediaQuery.of(context).size.width,
                ),
              ]));
  }
}
