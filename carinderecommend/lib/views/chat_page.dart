import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF18404),
        centerTitle: true,
        elevation: 5,
        title: const Text("CarindeRecommend"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              child: Container(
                height: screenHeight * 0.15,
                width: screenWidth,
                color: const Color(0xFFF18404),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
