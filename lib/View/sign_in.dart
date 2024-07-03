import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/View/colors.dart';

import '../Controller/sign_in_controller.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Get.find();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("images/BCA.jpg")),
            ),
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, 0, rect.height / 1.3));
              },
              blendMode: BlendMode.dstIn,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200),
                child: SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: Image.asset(
                    "images/momentumBackground.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: screenHeight / 1.7,
                child: Column(
                  children: [
                    Text("Welcome to Smart Steps",
                        style: TextStyle(
                            color: purpleTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.08)),
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    //   width: double.maxFinite,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(),
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       "continueWithGoogle".tr,
                    //       style: const TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w500,
                    //           color: purpleTextColor),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    //   width: double.maxFinite,
                    //   decoration: BoxDecoration(
                    //       color: orangeColor.withOpacity(0.5),
                    //       border: Border.all(),
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       "continueWithFacebook".tr,
                    //       style: const TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w500,
                    //           color: purpleTextColor),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: signInController.formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "enterAnEmail".tr;
                                      }
                                      if (!RegExp(
                                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                          .hasMatch(val)) {
                                        return "enterValidEmail".tr;
                                      }

                                      return null;
                                    },
                                    onSaved: (emailAddress) {
                                      signInController.userEmailAddress =
                                          emailAddress;
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.mail_outline_rounded),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: orangeColor, width: 2.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      hintText: 'Email',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GetBuilder<SignInController>(builder: (cntx) {
                                    return TextFormField(
                                      obscureText:
                                          signInController.showPassword,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enterPassword".tr;
                                        }
                                        if (value.length > 20) {
                                          return "password>20".tr;
                                        }
                                        if (value.length < 8) {
                                          return "password<8".tr;
                                        }

                                        return null;
                                      },
                                      onSaved: (password) {
                                        signInController.userPassword =
                                            password;
                                      },
                                      decoration: InputDecoration(
                                        focusColor: orangeColor,
                                        hoverColor: orangeColor,
                                        prefixIconColor: Colors.black,
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              signInController
                                                  .invertShowPassword();
                                            },
                                            icon: signInController.showPassword
                                                ? const Icon(Icons.visibility)
                                                : const Icon(
                                                    Icons.visibility_off)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: orangeColor, width: 2.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        hintText: 'Password',
                                      ),
                                    );
                                  }),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: orangeColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: TextButton(
                                      onPressed: () {
                                        if (signInController
                                            .formKey.currentState!
                                            .validate()) {
                                          signInController.formKey.currentState!
                                              .save();
                                          print(signInController.userPassword);
                                          signInController.signInAUser();
                                        }
                                      },
                                      child: Text(
                                        "login".tr,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: purpleTextColor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // RichText(
                                  //   text: TextSpan(
                                  //       text: "forgotYourPassword?".tr,
                                  //       style: TextStyle(
                                  //         fontSize: screenWidth * 0.04,
                                  //         color: orangeColor,
                                  //       ),
                                  //       recognizer: TapGestureRecognizer()
                                  //         ..onTap = () {}),
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "dontHaveAccount".tr,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                            text: 'create1'.tr,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              color: orangeColor,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                signInController.createOne();
                                              }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
