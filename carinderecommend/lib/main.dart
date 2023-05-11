import 'package:carinderecommend/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'bindings.dart';
import 'views/detection_screen.dart';

// import 'views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GlobalBindings(),
      title: 'CarindeRecommend',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner:
          false, // remove comments once deployed in production
      home: const DetectionScreen(),
    );
  }
}
