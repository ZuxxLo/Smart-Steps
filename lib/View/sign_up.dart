import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/Controller/sign_up_controller.dart';
import 'package:momentum/View/colors.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.find();

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
              child: SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: Image.asset(
                    "images/momentumBackground.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.grey.withOpacity(0.4))),
                )),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: screenHeight / 1.58,
                child: Column(
                  children: [
                    Text("Welcome To Smart Steps",
                        style: TextStyle(
                            color: purpleTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.08)),
                    const SizedBox(
                      height: 10,
                    ),
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
                              autovalidateMode: AutovalidateMode.always,
                              key: signUpController.formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    onSaved: (username) {
                                      signUpController.userName =
                                          username?.trim();
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
                                      prefixIcon: const Icon(
                                          Icons.person_pin_outlined),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: orangeColor, width: 2.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      hintText: 'username'.tr,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
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
                                      signUpController.userEmailAddress =
                                          emailAddress?.trim();
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
                                      hintText: 'E-mail',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GetBuilder<SignUpController>(builder: (cntx) {
                                    return TextFormField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText:
                                          signUpController.showPassword,
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
                                        signUpController.userPassword =
                                            password?.trim();
                                      },
                                      decoration: InputDecoration(
                                        focusColor: orangeColor,
                                        hoverColor: orangeColor,
                                        prefixIconColor: Colors.black,
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              signUpController
                                                  .invertShowPassword();
                                            },
                                            icon: signUpController.showPassword
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
                                        hintText: 'password'.tr,
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
                                        if (signUpController
                                            .formKey.currentState!
                                            .validate()) {
                                          signUpController.formKey.currentState!
                                              .save();
                                          signUpController.createNewUser();
                                        }
                                      },
                                      child: Text(
                                        "signUp".tr,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: purpleTextColor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // RichText(
                                  //   text: TextSpan(
                                  //     children: [
                                  //       TextSpan(
                                  //         text: "dontHaveAccount".tr,
                                  //         style: TextStyle(
                                  //             fontSize: screenWidth * 0.04,
                                  //             color: Colors.black),
                                  //       ),
                                  //       TextSpan(
                                  //           text: 'create1'.tr,
                                  //           style: TextStyle(
                                  //             fontSize: screenWidth * 0.04,
                                  //             color: orangeColor,
                                  //           ),
                                  //           recognizer: TapGestureRecognizer()
                                  //             ..onTap = () {}),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
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
