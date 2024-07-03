import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/Controller/new_habit_controller.dart';
import 'package:momentum/Model/reminder_model.dart';
import 'package:momentum/View/colors.dart';
import 'package:momentum/View/widgets.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:momentum/main.dart';

class NewHabit extends StatelessWidget {
  const NewHabit({super.key});
  static final habitNameShakeKey = GlobalKey<ShakeWidgetState>();
  static final habitEmojiShakeKey = GlobalKey<ShakeWidgetState>();

  @override
  Widget build(BuildContext context) {
    final NewHabitController newHabitController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    void goBack() {
      Navigator.pop(context);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(
          title: "newHabitTitle".tr,
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
              if (newHabitController.habitNameTextController.text.isEmpty) {
                habitNameShakeKey.currentState?.shake();
              }

              if (newHabitController.emoji.isEmpty) {
                habitEmojiShakeKey.currentState?.shake();
              }

              if (newHabitController.habitNameTextController.text.isNotEmpty &&
                  newHabitController.emoji.isNotEmpty) {
                newHabitController.createNewHabit();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("images/inCongratulationDialog.png"),
                        Text(
                          "Congratulations".tr,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: purpleTextColor),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: orangeColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(7)),
                          child: TextButton(
                            onPressed: () {
                              newHabitController.habitNameTextController.text =
                                  "";
                              newHabitController.emoji = "";

                              Get.back();
                              Get.offAllNamed('/');
                            },
                            child: Text(
                              "continue".tr,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: purpleTextColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
            child: const Icon(
              Icons.done,
              size: 30,
            )),
      ),
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          const BackgroundWidget(),
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ShakeWidget(
                          key: habitNameShakeKey,
                          shakeCount: 3,
                          shakeOffset: 10,
                          shakeDuration: const Duration(milliseconds: 500),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                // border: Border.all(
                                //   color: Colors.red,
                                // ),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                                autofocus: false,
                                onChanged: (value) {
                                  newHabitController
                                      .habitNameTextController.text = value;
                                },
                                style: const TextStyle(color: purpleTextColor),
                                decoration: InputDecoration(
                                    hintText: "enterNewHabitTitle".tr,
                                    hintStyle:
                                        const TextStyle(color: purpleTextColor),
                                    prefixIconColor: purpleTextColor,
                                    fillColor: purpleTextColor,
                                    focusColor: purpleTextColor,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    prefixIcon: const Icon(
                                      Icons.app_registration_rounded,
                                      color: purpleTextColor,
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        0, 14, 0, 0))),
                          ),
                        ),
                      ),
                      ShakeWidget(
                        key: habitEmojiShakeKey,
                        shakeCount: 3,
                        shakeOffset: 10,
                        shakeDuration: const Duration(milliseconds: 500),
                        child: IconButton(
                            onPressed: () async {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: EmojiSelector(
                                      padding: const EdgeInsets.all(10),
                                      columns: 7,
                                      onSelected: (emoji) {
                                        newHabitController.emoji = emoji.char;
                                        navigator!.pop(context);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.emoji_symbols_sharp,
                              color: purpleTextColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  //////////////////////////////////////////////////
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(15)),
                     child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                  "You can customize:"), // "habitFrequency".tr
                            ),
                            TextButton.icon(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(orangeColor)),
                              onPressed: () {
                                if (newHabitController.daySelected != null) {
                                  Get.defaultDialog(
                                      title: " ",
                                      content: Column(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                newHabitController
                                                    .minusFrequency();
                                                Get.back();
                                              },
                                              child: const Text("Remove this day")),
                                          TextButton(
                                              onPressed: () {
                                                newHabitController
                                                    .addFrequency();
                                                Get.back();
                                              },
                                              child: const Text("Keep this day"))
                                        ],
                                      ));
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (context) => AlertDialog(
                                  //           content: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceAround,
                                  //               children: [
                                  //                 IconButton(
                                  //                     onPressed: (() =>
                                  //                         newHabitController
                                  //                             .minusFrequency()),
                                  //                     icon: const Icon(
                                  //                       Icons.remove_circle,
                                  //                       color: orangeColor,
                                  //                     )),
                                  //                 GetBuilder<
                                  //                         NewHabitController>(
                                  //                     builder: (context) {
                                  //                   return Text(
                                  //                     newHabitController
                                  //                         .affichageFrequency(),
                                  //                     style: const TextStyle(
                                  //                         fontSize: 20),
                                  //                   );
                                  //                 }),
                                  //                 IconButton(
                                  //                     onPressed: (() =>
                                  //                         newHabitController
                                  //                             .addFrequency()),
                                  //                     icon: const Icon(
                                  //                       Icons.add_circle,
                                  //                       color: orangeColor,
                                  //                     ))
                                  //               ]),
                                  //         ));
                                } else {
                                  MainFunctions.somethingWentWrongSnackBar(
                                      "Please select a day first");
                                }
                              },
                              icon: const Text("Custom"),
                              label: const Icon(
                                  Icons.arrow_forward_ios_outlined),
                            )
                          ],
                        ),
                        const Divider(
                          color: purpleTextColor,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          alignment: WrapAlignment. center,
                          spacing: 0,
                          children: List<Widget>.generate(
                              newHabitController.weekList.length,
                              (index) => Material(
                                    borderOnForeground: true,
                                    color: transparentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        newHabitController.selectADay(
                                            newHabitController
                                                .weekList[index].day);
                                      },
                                      highlightColor:
                                          Colors.yellow.withOpacity(0.3),
                                      splashColor: orangeColor.withOpacity(0.5),
                                      focusColor: Colors.green.withOpacity(0.0),
                                      hoverColor: Colors.blue.withOpacity(0.8),
                                      child: GetBuilder<NewHabitController>(
                                          builder: (context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: newHabitController
                                                      .getRightColor(
                                                          newHabitController
                                                              .weekList[index]
                                                              .day))),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(1),
                                                alignment: Alignment.center,
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: orangeColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Text(
                                                  newHabitController
                                                      .weekList[index].dayName
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(15)),
                    height: screenHeight * 0.08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Reminder".tr),
                        TextButton.icon(
                          style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(orangeColor)),
                          onPressed: () {
                            if (newHabitController.daySelected != null &&
                                int.parse(newHabitController
                                        .affichageFrequency()) >
                                    0) {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                                context: context,
                                builder: (context) {
                                  return GetBuilder<NewHabitController>(
                                      builder: (c) {
                                    return Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: newHabitController
                                                          .lenghtOfRemindersList() ==
                                                      0
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "NoReminders".tr,
                                                        style: const TextStyle(
                                                            fontSize: 30),
                                                      ),
                                                    )
                                                  : GridView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisSpacing:
                                                                  5,
                                                              mainAxisSpacing:
                                                                  5,
                                                              childAspectRatio:
                                                                  screenHeight *
                                                                      0.0014,
                                                              crossAxisCount:
                                                                  3),
                                                      itemCount: newHabitController
                                                          .lenghtOfRemindersList(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              color: orangeColor
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              if (newHabitController
                                                                      .isDeleteRemindersOn() ==
                                                                  true)
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: IconButton(
                                                                        onPressed: () {
                                                                          newHabitController
                                                                              .deleteSelectedReminder(index);
                                                                        },
                                                                        icon: const Icon(
                                                                          Icons
                                                                              .cancel,
                                                                          color:
                                                                              Colors.red,
                                                                          size:
                                                                              25,
                                                                        ))),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  // const SizedBox(
                                                                  //   height: 10,
                                                                  // ),
                                                                  Text(
                                                                    newHabitController
                                                                        .affichageReminderDayOftimeOnOff(
                                                                            context,
                                                                            index),
                                                                    style: const TextStyle(
                                                                      color: purpleTextColor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  // CupertinoSwitch(
                                                                  //   value: newHabitController
                                                                  //       .isSwitchReminderOn(
                                                                  //           index),
                                                                  //   onChanged:
                                                                  //       ((value) {
                                                                  //     newHabitController.switchReminderOnOff(
                                                                  //         index,
                                                                  //         value);
                                                                  //   }),
                                                                  //   thumbColor:
                                                                  //       purpleTextColor,
                                                                  //   activeColor:
                                                                  //       purpleTextColor
                                                                  //           .withOpacity(0.5),
                                                                  // )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: orangeColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        showTimePicker(
                                                          context: context,
                                                          helpText: "",
                                                          hourLabelText: "",
                                                          minuteLabelText: "",
                                                          initialEntryMode:
                                                              TimePickerEntryMode
                                                                  .dial,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        ).then((value) {
                                                          newHabitController
                                                              .addNewReminder(
                                                                  value,
                                                                  ReminderModel(
                                                                      reminder:
                                                                          value,
                                                                      isReminderOn:
                                                                          true));
                                                        });
                                                      },
                                                      child: Text(
                                                          "Reminder_add_Reminder"
                                                              .tr,
                                                          style: TextStyle(
                                                              color:
                                                                  purpleTextColor,
                                                              fontSize:
                                                                  screenWidth *
                                                                      0.05)),
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      newHabitController
                                                          .switchDeleteRemindersOnOff();
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                    )),
                                              ],
                                            )
                                          ]),
                                    );
                                  });
                                },
                              );
                            } else {
                              MainFunctions.somethingWentWrongSnackBar(
                                  "Please select or add a day");
                            }
                          },
                          icon: const Text("00:00"),
                          label: const Icon(Icons.arrow_forward_ios_outlined),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.02,
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  //   decoration: BoxDecoration(
                  //       color: whiteColor,
                  //       borderRadius: BorderRadius.circular(15)),
                  //   height: screenHeight * 0.08,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const Text('Notification'),
                  //       GetBuilder<NewHabitController>(builder: (context) {
                  //         return CupertinoSwitch(
                  //           value: newHabitController.isNotificationsOn(),
                  //           onChanged: ((value) {
                  //             newHabitController
                  //                 .switchNotificationsOnOff(value);
                  //           }),
                  //           thumbColor: purpleTextColor,
                  //           activeColor: purpleTextColor.withOpacity(0.5),
                  //         );
                  //       })
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
