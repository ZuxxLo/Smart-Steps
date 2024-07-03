import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/Controller/modify_profil_controller.dart';
import 'package:momentum/View/colors.dart';
import 'package:momentum/View/widgets.dart';

import '../main.dart';

class ModifyProfile extends StatelessWidget {
  const ModifyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final ModifyProfileController modifyProfileController = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: MyCustomAppBar(
          title: "PersonalInformation".tr,
          screenWidth: screenWidth,
          iconAction: null,
          iconLeading: Icons.arrow_back_ios_new,
          function: () {
            Get.back();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            color: orangeColor.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ]),
        child: FloatingActionButton(
            elevation: 0,
            foregroundColor: purpleTextColor,
            backgroundColor: orangeColor,
            onPressed: () {
              if (modifyProfileController.formKey.currentState!.validate()) {
                modifyProfileController.formKey.currentState!.save();
                modifyProfileController.updateInfos();
              }
            },
            child: const Icon(
              Icons.done,
              size: 30,
            )),
      ),
      body: ListView(
          padding: const EdgeInsets.all(25),
          shrinkWrap: true,
          children: [
            Center(
              child: SizedBox(
                  height: 120,
                  width: 120,
                  child: !(currentUserInfos.currentUserImageURL == "")
                      ? ClipOval(
                          child: MainFunctions.pickedImage == null
                              ? Image.network(
                                  currentUserInfos.currentUserImageURL
                                      .toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const CircularProgressIndicator();
                                  },
                                )
                              : Image.file(
                                  MainFunctions.pickedImage!,
                                  fit: BoxFit.cover,
                                ))
                      : ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            color: MainFunctions.generatePresizedColor(
                                currentUserInfos.currentUserName!.length),
                            child: Text(
                              currentUserInfos.currentUserName![0]
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 40, color: purpleTextColor),
                            ),
                          ),
                        )),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: modifyProfileController.formKey,
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onSaved: (username) {
                      modifyProfileController.newUserName = username?.trim();
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your username";
                      } else if (val.length > 10) {
                        return "Username can't be larger than 10 letter";
                      } else if (val.length < 3) {
                        return "Username can't be less than 3 letter";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_pin_outlined),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: orangeColor, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintText: 'username'.tr,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // GetBuilder<ModifyProfileController>(builder: (cntx) {
                  //   return TextFormField(
                  //     keyboardType: TextInputType.visiblePassword,
                  //     obscureText: modifyProfileController.showPassword,
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return null;
                  //       }
                  //       if (value.length > 20) {
                  //         return "password>20".tr;
                  //       }
                  //       if (value.length < 8) {
                  //         return "password<8".tr;
                  //       }

                  //       return null;
                  //     },
                  //     onSaved: (password) {
                  //       modifyProfileController.newPassword = password?.trim();
                  //     },
                  //     decoration: InputDecoration(
                  //       focusColor: orangeColor,
                  //       hoverColor: orangeColor,
                  //       prefixIconColor: Colors.black,
                  //       prefixIcon: const Icon(Icons.lock),
                  //       suffixIcon: IconButton(
                  //           onPressed: () {
                  //             modifyProfileController.invertShowPassword();
                  //           },
                  //           icon: modifyProfileController.showPassword
                  //               ? const Icon(Icons.visibility)
                  //               : const Icon(Icons.visibility_off)),
                  //       focusedBorder: const OutlineInputBorder(
                  //           borderSide:
                  //               BorderSide(color: orangeColor, width: 2.0),
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(15))),
                  //       border: const OutlineInputBorder(
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(15))),
                  //       hintText: 'password'.tr,
                  //     ),
                  //   );
                  // }),
                ],
              ),
            ),
          ]),
    );
  }
}
