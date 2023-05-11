import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageDetection extends StatefulWidget {
  const ImageDetection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageDetectionState createState() => _ImageDetectionState();
}

class _ImageDetectionState extends State<ImageDetection> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    // Prompt the user to take a picture with their device's camera
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        // If the user successfully took a picture, set the _image state variable to the captured file
        _image = File(pickedFile.path);
      } else {
        // If the user didn't take a picture, print a message to the console (for debugging purposes)
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  Future uploadImage(File? imageFile) async {
    if (imageFile == null) {
      // If no image was selected, print a message to the console (for debugging purposes) and exit the function
      if (kDebugMode) {
        print('No image selected.');
      }
      return;
    }
    // Convert the selected file to a byte stream
    var stream = http.ByteStream(imageFile.openRead());
    // Get the length of the selected file
    var length = await imageFile.length();
    // Define the URL of the API endpoint that will receive the image
    var uri = Uri.parse("http://192.168.254.151:4000/upload");

    // Create a new multipart HTTP request
    var request = http.MultipartRequest("POST", uri);
    // Create a new multipart file from the byte stream
    var multipartFile =
        http.MultipartFile('file', stream, length, filename: imageFile.path);

    // Add the multipart file to the request
    request.files.add(multipartFile);

    // Send the HTTP request and wait for the response
    var response = await request.send();
    // Print the status code of the HTTP response (for debugging purposes)
    if (kDebugMode) {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Camera Upload"),
      ),
      body: Center(
        child: _image == null
            ? const Text('No image selected.')
            : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // When the floating action button is pressed, take a picture and upload it to the server
          getImage().then((value) => uploadImage(_image));
        },
        tooltip: 'Pick Image',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
