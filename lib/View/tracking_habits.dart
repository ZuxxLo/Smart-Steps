import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/View/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../Controller/home_screen_controller.dart';

class TrackingHabits extends StatelessWidget {
  const TrackingHabits({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController homeScreenController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    DateFormat dateFormat = DateFormat('EEE');
    DateTime focusedDay = DateTime.now();
    const boxDecoC = BoxDecoration(shape: BoxShape.rectangle);

    return Scaffold(
      backgroundColor: transparentColor,
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
              Get.toNamed("/NewHabit");
            },
            child: const Icon(
              Icons.add,
              size: 30,
            )),
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Center(
              child: Text(
                "mainTitle".tr,
                style: TextStyle(color: purpleTextColor,
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
              ),
            ),

            // TextButton(
            //     onPressed: () async {
            //       // await AwesomeNotifications().createNotification(
            //       //     content: NotificationContent(
            //       //       fullScreenIntent: false,
            //       //       category: NotificationCategory.Reminder,
            //       //       id: 10,
            //       //       groupKey: '10key',
            //       //       channelKey: 'basic_channel',
            //       //       title: '       eating dick',
            //       //       body:
            //       //           '${Emojis.time_alarm_clock}18 : 00 ${Emojis.time_alarm_clock}',
            //       //     ),
            //       //     actionButtons: [
            //       //       NotificationActionButton(
            //       //           key: 'SHOW_SERVICE_DETAILS', label: 'Show details')
            //       //     ]);

            //       AwesomeNotifications().createNotification(
            //           content: NotificationContent(
            //               id: 10,
            //               channelKey: 'habits_channel',
            //               title: 'Simple Notification',
            //               color: Colors.transparent,

            //               body: 'Simple body',
            //               actionType: ActionType.Default));
            //       // Hive.deleteFromDisk();
            //     },
            //     child: Icon(Icons.delete_forever)),
            // Container(
            //   width: screenWidth,
            //   margin: EdgeInsets.fromLTRB(20, 15, 20, 20),
            //   height: screenHeight * 0.2,
            //   decoration: BoxDecoration(
            //       color: whiteColor,
            //       image: DecorationImage(
            //           alignment: Alignment.centerRight,
            //           image: AssetImage('images/quote_image.png'))),
            //   child: Text(
            //     "stsdqdsqdqsdqsdfdqsdzaeazeazsquf",
            //   ),
            // ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: 100,
              child: SfCalendar(
                viewNavigationMode: ViewNavigationMode.snap,
                selectionDecoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  shape: BoxShape.rectangle,
                ),
                initialSelectedDate: DateTime.now(),
                firstDayOfWeek: 6,
                minDate: DateTime.now(),
                viewHeaderHeight: 0,
                headerHeight:30,
                view: CalendarView.month,
                monthCellBuilder: (context, details) {
                  if (details.date.day == DateTime.now().day) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: purpleTextColor.withOpacity(0.9),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${dateFormat.format(details.date)}\n${(details.date.day)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: whiteColor),
                      ),
                    );
                  } else if (details.date.isBefore(DateTime.now())) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${dateFormat.format(details.date)}\n${(details.date.day)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: whiteColor),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: whiteColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${dateFormat.format(details.date)}\n${(details.date.day)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: purpleTextColor),
                      ),
                    );
                  }
                },
                monthViewSettings: const MonthViewSettings(
                    dayFormat: 'EEE',
                    numberOfWeeksInView: 1,
                    appointmentDisplayCount: 2,
                    appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                    showAgenda: false,
                    navigationDirection: MonthNavigationDirection.horizontal),
                onTap: (calendarTapDetails) {
                  homeScreenController
                      .getHabits(calendarTapDetails.date!.weekday);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
              Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GetBuilder<HomeScreenController >(
                builder: (context) {
                  return Visibility(
                    visible: homeScreenController.habitsOfSelectedDay.isNotEmpty,
                    child: const Text(
                      "Habits",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: purpleTextColor),
                    ),
                  );
                }
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GetBuilder<HomeScreenController>(builder: (context) {
              if (homeScreenController.habitsOfSelectedDay.isEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      width: 600,
                      child: Lottie.asset("images/emptyLottie.json",
                          fit: BoxFit.fitWidth),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const Text(
                    //   "There is no habit, Please add one",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 25,
                    //     color: Colors.deepPurple,
                    //   ),
                    // ),
                  ],
                );
              } else {
                return GetBuilder<HomeScreenController>(builder: (context) {
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemCount: homeScreenController.habitsOfSelectedDay.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: purpleTextColor,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              homeScreenController
                                  .habitsOfSelectedDay[index].habitName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: whiteColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              homeScreenController
                                  .habitsOfSelectedDay[index].emoji
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      );
                    },
                  );
                });

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: homeScreenController.habitsOfSelectedDay.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: whiteColor,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          homeScreenController
                              .habitsOfSelectedDay[index].habitName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: purpleTextColor,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: screenWidth * 0.11,
                          width: screenWidth * 0.11,
                          decoration: BoxDecoration(
                              color: orangeColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            homeScreenController
                                .habitsOfSelectedDay[index]
                                .weekList[homeScreenController.selectedDay!]
                                .frequency
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            })

            // SizedBox(
            //   height: 80,
            //   child: ListView(
            //     children: [
            //       TableCalendar(
            //            daysOfWeekHeight: 0,
            //           headerVisible: false,
            //           calendarBuilders: CalendarBuilders(
            //               todayBuilder: (context, day, focusedDay) => Padding(
            //                     padding: const EdgeInsets.only(right: 4, left: 4),
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                         color: whiteColor,
            //                         border: Border.all(
            //                             color: Colors.deepPurple, width: 2),
            //                         borderRadius: const BorderRadius.all(
            //                             Radius.circular(10)),
            //                       ),
            //                       alignment: Alignment.center,
            //                       child: Text(
            //                         "${dateFormat.format(day)}\n${(day.day)}",
            //                         textAlign: TextAlign.center,
            //                         style: TextStyle(color: purpleTextColor),
            //                       ),
            //                     ),
            //                   ),
            //               defaultBuilder: (context, day, focusedDay) {
            //                 // if (day.day == DateTime.now().day) {
            //                 //   return Container(
            //                 //     margin: const EdgeInsets.all(8.0),
            //                 //     decoration: BoxDecoration(
            //                 //       borderRadius:
            //                 //           const BorderRadius.all(Radius.circular(10)),
            //                 //       color: purpleTextColor.withOpacity(0.9),
            //                 //     ),
            //                 //     alignment: Alignment.center,
            //                 //     child: Text(
            //                 //       "${dateFormat.format(day)}\n${(day.day)}",
            //                 //       textAlign: TextAlign.center,
            //                 //       style: TextStyle(color: whiteColor),
            //                 //     ),
            //                 //   );
            //                 // } else if (day.isBefore(DateTime.now())) {
            //                 //   return Container(
            //                 //     margin: const EdgeInsets.all(8.0),
            //                 //     decoration: BoxDecoration(
            //                 //       borderRadius:
            //                 //           const BorderRadius.all(Radius.circular(10)),
            //                 //       color: Colors.grey.withOpacity(0.3),
            //                 //     ),
            //                 //     alignment: Alignment.center,
            //                 //     child: Text(
            //                 //       "${dateFormat.format(day)}\n${(day.day)}",
            //                 //       textAlign: TextAlign.center,
            //                 //       style: TextStyle(color: whiteColor),
            //                 //     ),
            //                 //   );
            //                 // } else
            //                 {
            //                   return Expanded(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           alignment: Alignment.center,
            //                           child: Text(
            //                             "${dateFormat.format(day)}\n${(day.day)}",
            //                             textAlign: TextAlign.center,
            //                             style: TextStyle(color: purpleTextColor),
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           height: 10,
            //                         ),
            //                         Wrap(
            //                             runSpacing: 10,
            //                             direction: Axis.horizontal,
            //                             children: List<Widget>.generate(
            //                               homeScreenController.habitsBox.length,
            //                               (index) => Container(
            //                                 alignment: Alignment.center,
            //                                 height: screenWidth * 0.125,
            //                                 width: screenWidth * 0.125,
            //                                 decoration: BoxDecoration(
            //                                     color: orangeColor,
            //                                     borderRadius:
            //                                         BorderRadius.circular(12)),
            //                                 child: Text(
            //                                   homeScreenController.habitsBox
            //                                       .get(index)!
            //                                       .weekList[day.weekday - 1]
            //                                       .frequency
            //                                       .toString(),
            //                                   textAlign: TextAlign.center,
            //                                   style: TextStyle(
            //                                       fontSize: screenWidth * 0.06,
            //                                       fontWeight: FontWeight.w500),
            //                                 ),
            //                               ),
            //                             ))
            //                       ],
            //                     ),
            //                   );
            //                 }
            //               }),
            //           // availableCalendarFormats:,
            //           calendarFormat: CalendarFormat.week,
            //           focusedDay: _focusedDay,
            //           firstDay: DateTime.utc(DateTime.now().year,
            //               DateTime.now().month, DateTime.now().day),
            //           lastDay: DateTime.utc(DateTime.now().year,
            //               DateTime.now().month, DateTime.now().day + 20)),
            //     ],
            //   ),
            // ),
          ]),
    );
  }
}

Future<void> dction(var receivedAction) async {
  print(receivedAction);
  print('**********************');
}
