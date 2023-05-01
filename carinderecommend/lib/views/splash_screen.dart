import 'package:carinderecommend/views/dashboard.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonWidth = screenWidth * 0.55;
    final buttonHeight = screenHeight * 0.07;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashscreen_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.55,
                // color: Colors.black,
              ),
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: const TextSpan(
                          text: 'See. ',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Taste.',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w900,
                                color: Colors.orange,
                              ),
                            ),
                            TextSpan(
                              text: '\nSavor. ',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'Repeat.',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w900,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "An AI-Driven Food App that uses Object Detection and GPT-3 for Recommendation Systems.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(buttonHeight / 2),
                        ),
                        backgroundColor: const Color(0xFFF18404),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const Dashboard()),
                        ),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
