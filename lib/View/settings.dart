import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:momentum/Controller/home_screen_controller.dart';
import 'package:momentum/Controller/settings_controller.dart';
import 'package:momentum/View/colors.dart';
import 'package:momentum/View/widgets.dart';

import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();
    final HomeScreenController homeScreenController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: transparentColor,
      appBar: MyCustomAppBar(
          title: "Settings".tr,
          screenWidth: screenWidth,
          iconAction: null,
          iconLeading: null,
          function: () {}),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Text(
            //   "Account".tr,
            //   style: TextStyle(
            //       fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(
              height: 30,
            ),
            GetBuilder<HomeScreenController>(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: currentUserInfos.currentUserImageURL == ""
                        ? CircleAvatar(
                            backgroundColor:
                                MainFunctions.generatePresizedColor(
                                    currentUserInfos.currentUserName!.length),
                            child: Text(
                              currentUserInfos.currentUserName![0]
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 50, color: purpleTextColor),
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                                currentUserInfos.currentUserImageURL!),
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(currentUserInfos.currentUserName!,
                      style: const TextStyle(
                          fontSize: 26,
                          color: purpleTextColor,
                          fontWeight: FontWeight.bold)),
                ],
              );
            }),

            const SizedBox(
              height: 13,
            ),
            const Divider(thickness: 4),
            const SizedBox(
              height: 13,
            ),
// ///////////////// lANGAGE
//             Text(
//               "Settings".tr,
//               style: TextStyle(
//                   fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                    title: "Do you want to delete all the habits?",
                    titleStyle: const TextStyle(color: purpleTextColor),
                    content: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                              homeScreenController.deleteAllHabits();
                            },
                            child: const Text("Confirm")),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("Cancel"))
                      ],
                    ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromRGBO(255, 64, 6, 0.686),
                          child: Icon(
                            Icons.delete_forever_outlined,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Delete Habits",
                            style: TextStyle(
                                fontSize: 20,
                                color: purpleTextColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            InkWell(
              onTap: () {
                Get.toNamed("/QuizScreen");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromRGBO(252, 198, 0, 0.471),
                          child: Icon(
                            Icons.grade_outlined,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Points",
                            style: TextStyle(
                                fontSize: 20,
                                color: purpleTextColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GetBuilder<SettingsController>(builder: (context) {
                      return Text(currentUserInfos.currentUserPoints.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              color: purpleTextColor,
                              fontWeight: FontWeight.bold));
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.toNamed("/Rewards");
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromRGBO(92, 231, 241, 0.675),
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Rewards",
                            style: TextStyle(
                                fontSize: 20,
                                color: purpleTextColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                    title: " ",
                    content: SingleChildScrollView(
                      child: Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent],
                              ).createShader(
                                  Rect.fromLTRB(0, 0, 0, rect.height / 1.3));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.asset("images/BCA.jpg")),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Coach: Mebekhout Imen",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Coach: Belkhodja Rania",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Hamame Ousssama",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Bouzidi Malak",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Elarbi Wieam Nesrine ",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Mestfaoui Amel",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Belessel Malika",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Ammari kamar Eddine ",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Benthabet Hanae",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Special thanks: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.white),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Hamame Mohamed Amine",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Fellah Mohammed Nassim",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Aggad Redouane ",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Bechaib Zakariaa",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              const Text(
                                "Bencherif Abdelhadi",
                                style: TextStyle(backgroundColor: Colors.white),
                              ),
                              Center(
                                child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("OK")),
                              )
                            ],
                          ),
                        ],
                      ),
                    ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromRGBO(152, 0, 234, 0.675),
                          child: Icon(
                            Icons.info_outline,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("About Us",
                            style: TextStyle(
                                fontSize: 20,
                                color: purpleTextColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
//             InkWell(
//               onTap: () {
//                 settingsController.setLanguage();
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Row(
//                       children: [
//                         const CircleAvatar(
//                           backgroundColor: Color.fromRGBO(61, 99, 212, 0.471),
//                           child: Icon(
//                             Icons.language,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Language".tr,
//                                 style: const TextStyle(
//                                     fontSize: 20,
//                                     color: purpleTextColor,
//                                     fontWeight: FontWeight.bold)),
//                             Text(
//                                 settingsController.localeValue == "fr"
//                                     ? "francais".tr
//                                     : "english".tr,
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.grey)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   // PopupMenuButton<int>(
//                   //   iconSize: 40,
//                   //   icon: const Icon(
//                   //     Icons.arrow_drop_down,
//                   //   ),
//                   //   itemBuilder: (context) => [
//                   //     PopupMenuItem(
//                   //       onTap: () {},
//                   //       value: 1,
//                   //       child: Text("english".tr),
//                   //     ),
//                   //     PopupMenuItem(
//                   //       onTap: () {},
//                   //       value: 2,
//                   //       child: Text("francais".tr),
//                   //     ),
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
// /////////////////// DARK MODE
//             const SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: () {
//                 settingsController.setDarkTheme();
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Row(
//                       children: [
//                         const CircleAvatar(
//                           backgroundColor: Color.fromARGB(111, 136, 24, 248),
//                           child: Icon(
//                             Icons.dark_mode,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         Text("DarkMode".tr,
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 color: purpleTextColor,
//                                 fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   ),
//                   CupertinoSwitch(
//                     value: false,
//                     trackColor: orangeColor.withOpacity(0.7),
//                     thumbColor: purpleTextColor,
//                     activeColor: purpleTextColor.withOpacity(0.5),
//                     onChanged: (value) {
//                       print(currentUser!.uid);
//                       print(currentUserInfos.currentUserUID);
//                       print(currentUser!.email);
//                       print(currentUserInfos.currentUserEmail);
//                     },
//                   )
//                 ],
//               ),
//             ),

            const SizedBox(
              height: 50,
            ),
            /////////////////////// Sign out
            TextButton.icon(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(purpleTextColor),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red.withOpacity(0.5))),
                label: const Icon(Icons.logout),
                onPressed: () {
                  settingsController.signOutOfAnExistingAccount();
                },
                icon: Text("signOut".tr,
                    style: const TextStyle(
                      fontSize: 20,
                    )))
          ],
        ),
      ),
    );
  }
}
