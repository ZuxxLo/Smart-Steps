
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class ModifyProfileController extends GetxController {
  String? newUserName;
  String? newImageURL;
  // String? newPassword;
  bool showPassword = false;
  final formKey = GlobalKey<FormState>();

  invertShowPassword() {
    showPassword = !showPassword;
    update();
  }

  updateInfos() async {
    ///update username
    ///
    
    if (newUserName != null &&
        newUserName != "" &&
        newUserName != currentUserInfos.currentUserName) {
      FirebaseAuth.instance.currentUser!.updateDisplayName(newUserName);
      currentUserInfos.setCurrentUserName = newUserName;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.uid)
          .update({
        "UserName": newUserName,
      });
      MainFunctions.successSnackBar("success".tr);
    } else if (newUserName == currentUserInfos.currentUserName || newUserName != null && newUserName == "") {
      MainFunctions.somethingWentWrongSnackBar("ownUsername".tr);
    }
    /////
    ///update password
    // if (newPassword != null && newPassword != "") {
    //   FirebaseAuth.instance.currentUser!.updateDisplayName(newPassword);
    // }
    /////
    if (newImageURL != null) {
      FirebaseAuth.instance.currentUser!.updatePhotoURL(newImageURL);
      currentUserInfos.setCurrentUserImageURL = newImageURL;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.uid)
          .update({
        "ImageURL": newUserName,
      });
    }
    /////

    update();
  }

  // uploadPicture() async {
  //   var status = await Permission.storage.request();
  //   if (status.isDenied) {
  //     status = await Permission.storage.request();
  //   } else if (status.isPermanentlyDenied) {
  //     Get.defaultDialog(
  //       title: "pleaseAllowPermissions".tr,
  //       content: TextButton(
  //           style: ButtonStyle(
  //               fixedSize: MaterialStateProperty.all(
  //                   const Size(double.maxFinite, 45))),
  //           onPressed: () {
  //             openAppSettings();
  //           },
  //           child: Text("openAppSettings".tr)),
  //     );
  //   } else if (status.isGranted) {
  //     try {
  //       final image = await ImagePicker()
  //           .pickImage(source: ImageSource.gallery, imageQuality: 85);
  //       if (image == null) return;
  //       MainFunctions.pickedImage = File(image.path);

  //       var size = MainFunctions.pickedImage?.readAsBytesSync().lengthInBytes;
  //       if (size! <= 2097152) {
  //         var response = await Crud.postRequestWithFile(
  //             "$usersLink/update/photo", {}, MainFunctions.pickedImage!);

  //         if (response != null && response["success"] == true) {
  //           // imageCache.clear();
  //           // PaintingBinding.instance.imageCache.clear();
  //           // imageCache.clearLiveImages();
  //         } else {
  //           MainFunctions.somethingWentWrongSnackBar("${response["message"]}");
  //         }
  //       } else {
  //         MainFunctions.somethingWentWrongSnackBar("imageTooBig".tr);
  //       }
  //     } catch (e) {
  //       MainFunctions.somethingWentWrongSnackBar("$e");
  //     }
  //   }

  //   update();
  // }
}
