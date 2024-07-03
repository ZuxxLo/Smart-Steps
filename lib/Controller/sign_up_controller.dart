import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;
  String? userName;
  String? userEmailAddress;
  String? userPassword;

  invertShowPassword() {
    showPassword = !showPassword;
    update();
  }

  createNewUser() async {
    Get.defaultDialog(
        title: "pleaseWait".tr, content: const CircularProgressIndicator());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmailAddress!,
        password: userPassword!,
      );

      FirebaseFirestore.instance
          .collection("Users")
          .doc(credential.user!.uid)
          .set({
        "UID": credential.user!.uid,
        "Email": userEmailAddress,
        "UserName": userName,
        "ImageURL": "",
        "Points":0
      });
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Get.back();

      Get.toNamed("/EmailVerification");
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'weak-password') {
        Get.defaultDialog(
          title: "weakPassword".tr,
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code  == 'email-already-in-use') {
        Get.defaultDialog(
          title: "emailInUse".tr,
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      Get.back();

      print(e);
    }
  }
}
