// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:momentum/View/new_habit.dart';
// import 'package:momentum/utils/new_habit_binding.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class LocalNotifications {
//   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

//   static localNotificationsItialization(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('mipmap/ic_launcher');
//     const DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings();

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       macOS: initializationSettingsDarwin,
//     );
//     tz.initializeTimeZones();
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onDidReceiveBackgroundNotificationResponse: selectNotification,
//       // onDidReceiveNotificationResponse: selectNotification,
//     );
//   }

//   static showNotification(
//       {required notiId,
//       required String title,
//       required String body,
//       var payload,
//       required FlutterLocalNotificationsPlugin
//           flutterLocalNotificationsPlugin}) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'channel_id 6',
//       'your channel name',
//       playSound: true,
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     NotificationDetails notificationDetails =
//         const NotificationDetails(android: androidNotificationDetails);

//     await flutterLocalNotificationsPlugin
//         .show(notiId, title, body, notificationDetails, payload: payload);
//   }

//   static showRepeatNotification(
//       {required int notiId,
//       required String title,
//       required String body,
//       var payload,
//        required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
//       required int weekDay,
//       required int hour,
//       required int minutes}) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails(
//       "Habit's Reminders",
//       "Habit's Reminders",
//       channelDescription: "",
//       playSound: true,
//       importance: Importance.max,
//       priority: Priority.high,
//       fullScreenIntent: false,
//     );

//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       notiId,
//       title,
//       body,
//       tz.TZDateTime(
//           tz.local, now.year, now.month, now.day, hour, minutes, weekDay),
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//     );
//   }
// }

// tz.TZDateTime _convertTime(int weekDay, int hour, int minutes) {
//   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//   tz.TZDateTime scheduleDate = tz.TZDateTime(
//       tz.local, now.year, now.month, now.day, hour, minutes, weekDay);

//   return scheduleDate;
// }
