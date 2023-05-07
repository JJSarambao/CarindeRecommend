import 'package:flutter/material.dart';
import 'dart:math' as math;

class BoundingBox extends StatelessWidget {
  final List<dynamic> results;
  final double previewH;
  final double previewW;
  final double screenH;
  final double screenW;

  BoundingBox({
    required this.results,
    required this.previewH,
    required this.previewW,
    required this.screenH,
    required this.screenW,
  });

  @override
  Widget build(BuildContext context) {
    print(results);
    List<Widget> _renderBoxes() {
      return results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var screenRatio = screenH / screenW;
        var previewRatio = previewH / previewW;
        double x, y, w, h;

        if (screenRatio > previewRatio) {
          var difH = screenH - (previewH / previewW) * screenW;
          x = (_x / previewW) * screenW;
          w = (_w / previewW) * screenW;
          y = (_y / previewH) * (screenW - difH);
          h = (_h / previewH) * (screenW - difH);
        } else {
          var difW = screenW - (previewW / previewH) * screenH;
          x = (_x / previewW) * (screenH - difW);
          w = (_w / previewW) * (screenH - difW);
          y = (_y / previewH) * screenH;
          h = (_h / previewH) * screenH;
        }

        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFF18404),
                width: 3.0,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                color: Color(0xFFF18404),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList();
    }

    print(_renderBoxes());

    return Stack(
      children: _renderBoxes(),
    );
  }
}
