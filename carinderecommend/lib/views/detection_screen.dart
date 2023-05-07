import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'captured_image.dart';

class LiveCamera extends StatefulWidget {
  const LiveCamera({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LiveCameraState createState() => _LiveCameraState();
}

class _LiveCameraState extends State<LiveCamera> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for caputred image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      if (kDebugMode) {
        print("NO any camera found");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF18404),
        centerTitle: true,
        elevation: 5,
        title: const Text("CarindeRecommend Demo"),
      ),
      body: Stack(
        children: [
          controller != null && controller!.value.isInitialized
              ? Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: controller!.value.aspectRatio,
                    child: CameraPreview(controller!),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: SizedBox(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                child: FloatingActionButton(
                  onPressed: () async {
                    if (controller != null && controller!.value.isInitialized) {
                      try {
                        //disable rotation lock while taking picture
                        await SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);

                        final XFile capturedImage =
                            await controller!.takePicture();
                        setState(() {
                          image = capturedImage;
                        });

                        // navigate to next page with the captured image
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CapturedImagePage(image: capturedImage),
                          ),
                        );
                      } catch (e) {
                        if (kDebugMode) {
                          print(e);
                        } //show error
                      } finally {
                        //reenable rotation lock after taking picture
                        await SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight,
                        ]);
                      }
                    }
                  },
                  child: const Icon(Icons.camera),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
