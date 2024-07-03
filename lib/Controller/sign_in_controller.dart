import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/Model/user_model.dart';

import '../main.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;
  String? userEmailAddress;
  String? userPassword;

  createOne() {
    Get.toNamed("/SignUp");
  }

  invertShowPassword() {
    showPassword = !showPassword;
    update();
  }

  signInAUser() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "Please wait",
        content: const CircularProgressIndicator());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmailAddress!, password: userPassword!);

      print(credential);
      currentUser = FirebaseAuth.instance.currentUser;
      print("*/*/*/*/*/");

      print(currentUser!.emailVerified);
      print("*/*/*/*/*/");
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.uid)
          .get()
          .then(
        (value) async {
          print(value.data());
          currentUserInfos = UserModel(
              currentUserUID: value["UID"],
              currentUserEmail: value["Email"],
              currentUserName: value["UserName"],
              currentUserImageURL: value["ImageURL"],
              currentUserPoints: value["Points"]);
        },
      );
      Get.back();

      if (credential.user!.emailVerified) {
        Get.offAndToNamed("/");
      } else {
        Get.toNamed("/EmailVerification");
      }
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: "emailNotFound".tr,
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: "wrongPassword".tr,
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
      print(e);
      Get.defaultDialog(
        title: "something went wrong",
        content: const Icon(
          Icons.report_problem,
          color: Colors.red,
        ),
        onConfirm: () {
          Get.back();
        },
      );
      print(e);
    }
  }
}
