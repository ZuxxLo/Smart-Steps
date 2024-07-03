import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/main.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, 0, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Image.asset(
                "images/momentumBackground.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Smart Steps is a habit builder app to help its users focus more and quit scrolling on social media",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 400,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    MainFunctions.sharredPrefs
                        ?.setString("firstTimeOpenApp", "yes");
                    Get.offAndToNamed("/SignIn");
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
