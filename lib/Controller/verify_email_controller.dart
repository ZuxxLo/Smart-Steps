import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  bool isEmailVerified = false;
  resendVerificationEmail() async {
    if (!isEmailVerified) {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    }
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print("*/*/*/*/*/*");

    print(isEmailVerified);
    print("*/*/*/*/*/*");
  }

  @override
  void onInit() {    print("qsdqdsqsqsd");

    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        checkEmailVerified();
        if (isEmailVerified) {
          timer.cancel();
          Get.offAllNamed("/SignIn");
        }
      },
    );

    super.onInit();
  }
}
