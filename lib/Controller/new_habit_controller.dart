import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:momentum/Model/day_model.dart';
import 'package:momentum/Model/habit_model.dart';
import 'package:momentum/View/colors.dart';
import 'package:momentum/Model/reminder_model.dart';

class NewHabitController extends GetxController {
  List<DayModel> weekList = [
    DayModel(day: 6, dayName: "SAT", frequency: 1, reminders: []),
    DayModel(day: 7, dayName: "SUN", frequency: 1, reminders: []),
    DayModel(day: 1, dayName: "MON", frequency: 1, reminders: []),
    DayModel(day: 2, dayName: "TUE", frequency: 1, reminders: []),
    DayModel(day: 3, dayName: "WED", frequency: 1, reminders: []),
    DayModel(day: 4, dayName: "THU", frequency: 1, reminders: []),
    DayModel(day: 5, dayName: "FRI", frequency: 1, reminders: []),
  ];

  TextEditingController habitNameTextController = TextEditingController();
  // late TimeOfDay? reminderTime;
  int? daySelected;
  String emoji = "";
  final bool _isNotificationsOn = true;
  bool _isDeleteReminders = false;
  late Box<HabitModel> habitsBox;
  late Box remindersLengthPerDayBox;

  // static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  newHabitNameInput(String value) {
    habitNameTextController.text = value;
  }

  Map<int, int> temporaryRemindersLengthPerDay = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
  };

  int daySelectedinWeekList(int daySelected) {
    return weekList.indexWhere((element) => element.day == daySelected);
  }

  addNewReminder(TimeOfDay? value, ReminderModel reminder) {
    // int length = remindersLengthPerDayBox.get( weekList[daySelectedinWeekList(daySelected!)].dayName);
    int length = temporaryRemindersLengthPerDay[daySelected!]!;
    print("*********");

    if (length < 7 && value != null) {
      weekList[daySelectedinWeekList(daySelected!)].reminders.add(reminder);
      temporaryRemindersLengthPerDay[daySelected!] =
          temporaryRemindersLengthPerDay[daySelected!]! + 1;
    } else if (value != null && length == 7) {
      Get.defaultDialog(content: Text("7Reminders".tr), title: "!!!");
    }
    print(temporaryRemindersLengthPerDay[daySelected!]!);

    update();
  }

  deleteSelectedReminder(int index) {
    weekList[daySelectedinWeekList(daySelected!)].reminders.removeAt(index);
    temporaryRemindersLengthPerDay[daySelected!] =
        temporaryRemindersLengthPerDay[daySelected!]! - 1;
    if (weekList[daySelectedinWeekList(daySelected!)].reminders.isEmpty) {
      _isDeleteReminders = false;
    }

    update();
  }

  selectADay(index) {
    daySelected = index;
    print('dsq');
    print(habitsBox.length);
    habitsBox.toMap().forEach((key, value) {
      print(value.weekList[0].reminders.length);
    });

    // remindersLengthPerDayBox.putAll(temporaryRemindersLengthPerDay);

    // habitsBox.toMap().forEach((key, value) {
    //   print(value.habitName);
    //   // print(value.weekList[0].reminders[0].reminder);
    // });

    update();
  }

  switchReminderOnOff(index, valueBool) {
    weekList[daySelectedinWeekList(daySelected!)]
        .reminders[index]
        .isReminderOn = valueBool;
    update();
  }

  String affichageReminderDayOftimeOnOff(context, index) {
    weekList[daySelectedinWeekList(daySelected!)].reminders.sort(
      (a, b) {
        if (a.reminder!.hour != b.reminder!.hour) {
          return a.reminder!.hour.compareTo(b.reminder!.hour);
        } else {
          return a.reminder!.minute.compareTo(b.reminder!.minute);
        }
      },
    );

    return weekList[daySelectedinWeekList(daySelected!)]
        .reminders[index]
        .reminder!
        .format(context);
  }

  bool isSwitchReminderOn(index) {
    return weekList[daySelectedinWeekList(daySelected!)]
        .reminders[index]
        .isReminderOn;
  }

  bool isNotificationsOn() {
    return _isNotificationsOn;
  }

  switchNotificationsOnOff(value) {
    // LocalNotifications.showRepeatNotification(
    //     notiId: 1,
    //     title: "ze",
    //     body: "body",
    //     flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
    //     weekDay: 1,
    //     hour: 23,
    //     minutes: 05);
    // LocalNotifications.showRepeatNotification(
    //     notiId: 2,
    //     title: "ésqdqsqsqs",
    //     body: "body",
    //     flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
    //     weekDay: 2,
    //     hour: 23,
    //     minutes: 05);
    // _isNotificationsOn = value;

    update();
  }

  int lenghtOfRemindersList() {
    return weekList[daySelectedinWeekList(daySelected!)].reminders.length;
  }

  Color getRightColor(int index) {
    if (daySelected == index) {
      return orangeColor;
    } else {
      return transparentColor;
    }
  }

  addFrequency() {
    weekList[daySelectedinWeekList(daySelected!)].frequency = 1;
    update();
  }

  minusFrequency() {
    if (weekList[daySelectedinWeekList(daySelected!)].frequency != 0) {
      weekList[daySelectedinWeekList(daySelected!)].frequency = 0;
      print(weekList[daySelectedinWeekList(daySelected!)].frequency);
      print("/*/*/*//*/");
    }
    update();
  }

  String affichageFrequency() {
    return weekList[daySelectedinWeekList(daySelected!)].frequency.toString();
  }

  bool isDeleteRemindersOn() {
    return _isDeleteReminders;
  }

  switchDeleteRemindersOnOff() {
    _isDeleteReminders = !_isDeleteReminders;

    update();
  }

  createNewHabit() async {
    // List<DayModel> week = [];
    // for (DayModel dayElement in weekList) {
    //   week.add(DayModel(
    //       day: dayElement.day,
    //       dayName: dayElement.dayName,
    //       frequency: dayElement.frequency,
    //       reminders: dayElement.reminders));
    //   for (ReminderModel reminderElement in dayElement.reminders) {
    //     showNotification(
    //         id: idOfNoti,
    //         title: habitNameTextController.text,
    //         body: "${reminderElement.reminder!.hour}"
    //             "   :"
    //             "${reminderElement.reminder!.minute}",
    //         payload: "payload",
    //         weekDay: dayElement.day,
    //         hour: reminderElement.reminder!.hour,
    //         minutes: reminderElement.reminder!.minute);
    //     idOfNoti++;
    //   }
    // }

    print(habitNameTextController.text);
    habitsBox.add(HabitModel(
        habitName: habitNameTextController.text,
        emoji: emoji,
        weekList: weekList,
        isNotificationsOn: _isNotificationsOn));

    int tMRLPDIterator = 1;
    int remindersIterator = 0;
    for (DayModel dayElement in weekList) {
      for (ReminderModel reminderElement in dayElement.reminders) {
        // if (reminderElement.isReminderOn) {}
        String h;
        String m;
        if (reminderElement.reminder!.hour < 10) {
          h = "0${reminderElement.reminder!.hour}";
        } else {
          h = reminderElement.reminder!.hour.toString();
        }
        if (reminderElement.reminder!.minute < 10) {
          m = "0${reminderElement.reminder!.minute}";
        } else {
          m = reminderElement.reminder!.minute.toString();
        }

        print(concatenate2Numbers(
                    1, dayElement.day, remindersIterator));
        await AwesomeNotifications().createNotification(
            content: NotificationContent(
                category: NotificationCategory.Reminder,
                icon: null,
                color: Colors.transparent,
                id: concatenate2Numbers(
                    77, dayElement.day, remindersIterator),
                channelKey: 'habits_channel',
                groupKey: 'habits_channel_group',
                title:
                    "Its time for your habit: $emoji ${habitNameTextController.text} $emoji",
                body:
                    "${Emojis.time_alarm_clock} $h:$m  ${Emojis.time_alarm_clock}",
                actionType: ActionType.Default),
            schedule: NotificationCalendar(
                weekday: dayElement.day,
                hour: reminderElement.reminder!.hour,
                minute: reminderElement.reminder!.minute,
                second: 0,
                millisecond: 0,
                repeats: true));

        remindersIterator++;
      }

      remindersLengthPerDayBox.put(
          tMRLPDIterator, temporaryRemindersLengthPerDay[tMRLPDIterator]);
      tMRLPDIterator++;
    }
    update();
  }

 
  int concatenate2Numbers(int a, int b, int c) {
    return int.parse(a.toString() + b.toString() + c.toString());
  }

  trie() {
    List<DayModel> weedk = [];
    weedk.sort(
      (a, b) {
        return a.day.compareTo(b.day);
      },
    );
    List<ReminderModel> week = [];
    habitsBox.toMap().forEach((key, value) {
      for (var i = 0; i < weekList.length; i++) {
        for (var j = 0; j < value.weekList[i].reminders.length; j++) {
          week.add(value.weekList[i].reminders[j]);
        }
      }
    });
    week.sort(
      (a, b) {
        if (a.reminder!.hour != b.reminder!.hour) {
          return a.reminder!.hour.compareTo(b.reminder!.hour);
        } else {
          return a.reminder!.minute.compareTo(b.reminder!.minute);
        }
      },
    );
    for (var element in week) {
      print(element.reminder);
    }
  }

//weekList[daySelected!-1].reminders
  @override
  onInit() async {
    await Hive.openBox("RemindersLengthPerDayBox");
    // await Hive.openBox<ReminderModel>("reminders");
    // await Hive.openBox<DayModel>("days");
    remindersLengthPerDayBox = Hive.box("RemindersLengthPerDayBox");
    // remindersLengthPerDayBox.put(1, 7);
    // remindersLengthPerDayBox.put(2, 0);
    // remindersLengthPerDayBox.put(3, 0);
    // remindersLengthPerDayBox.put(4, 0);
    // remindersLengthPerDayBox.put(5, 0);
    // remindersLengthPerDayBox.put(6, 0);
    // remindersLengthPerDayBox.put(7, 0);

    // print('000000000000000000000000000');
    // remindersLengthPerDayBox.toMap().forEach((key, value) {
    //   print(
    //       "the key is :$key : the value is :${value}");
    //   temporaryRemindersLengthPerDay[key] = value;
    // });
    habitsBox = Hive.box<HabitModel>("habitsBox");
    // daysBox = Hive.box<DayModel>("days");
    // print(daysBox.values);
    // print('//////////////////////');
    // for (var i = 0; i < daysBox.length; i++) {
    //   weekList[i] = daysBox.getAt(i)!;
    // }
    update();
    ////////////////////////////////////////////////////////
    ///
    ///
    ///
    super.onInit();
  }

  @override
  void onClose() {
    habitNameTextController.dispose();
    super.onClose();
  }
}
