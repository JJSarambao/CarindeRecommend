import 'package:carinderecommend/views/image_detection.dart';
import 'package:carinderecommend/views/splash_screen.dart';
import 'package:flutter/material.dart';

// import 'views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Carinderecommend",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const ImageDetection(),
    );
  }
}
