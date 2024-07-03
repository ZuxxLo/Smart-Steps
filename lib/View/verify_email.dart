import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:momentum/View/widgets.dart';

import '../Controller/verify_email_controller.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailVerificationController emailVerificationController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyCustomAppBar(
          title: "emailVerification".tr,
          screenWidth: screenWidth,
          iconAction: null,
         iconLeading: Icons.arrow_back_ios_new,
          function: () {
            Get.back();
          }),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("emailVerificationSent".tr,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    emailVerificationController.resendVerificationEmail();
                  },
                  child: Text("resendVerificationEmail".tr,
                      style: const TextStyle(
                        fontSize: 20,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
