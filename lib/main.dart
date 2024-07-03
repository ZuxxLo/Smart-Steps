import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/View/on_boarding.dart';
import 'package:momentum/View/quiz_screen.dart';
import 'package:momentum/View/rewards.dart';
import 'package:momentum/middleware/auth_middleware.dart';
import 'package:momentum/utils/quiz_screen_binding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:optimize_battery/optimize_battery.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:momentum/Model/day_model.dart';
import 'package:momentum/Model/habit_model.dart';
import 'package:momentum/Model/reminder_model.dart';
import 'package:momentum/Model/user_model.dart';
import 'package:momentum/View/colors.dart';
import 'package:momentum/View/home_screen.dart';
import 'package:momentum/View/modify_profile.dart';
import 'package:momentum/View/new_habit.dart';
import 'package:momentum/View/sign_in.dart';
import 'package:momentum/View/settings.dart';
import 'package:momentum/View/sign_up.dart';
import 'package:momentum/View/verify_email.dart';
import 'package:momentum/View/videos_overview.dart';
import 'package:momentum/services/locale.dart';
import 'package:momentum/utils/home_screen_binding.dart';
import 'package:momentum/utils/modify_profil_binding.dart';
import 'package:momentum/utils/new_habit_binding.dart';
import 'package:momentum/utils/sign_in_bindning.dart';
import 'package:momentum/utils/sign_up_bindning.dart';
import 'package:momentum/utils/verify_email_binding.dart';
import 'package:momentum/utils/videos_binding.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:io';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// late final NotificationAppLaunchDetails? notificationAppLaunchDetails;

User? currentUser = FirebaseAuth.instance.currentUser;
UserModel currentUserInfos = UserModel(
    currentUserUID: "error",
    currentUserEmail: "error",
    currentUserName: "error",
    currentUserImageURL: "",
    currentUserPoints: 0);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
  //     overlays: [SystemUiOverlay.bottom]);
  // print(currentUser);
  // print("object");
  // if (currentUser != null) {
  //   MainFunctions.isLoggedIn = true;
  //   MainFunctions.getcurrentUserInfos();
  // }

  currentUser = FirebaseAuth.instance.currentUser;

  MainFunctions.sharredPrefs = await SharedPreferences.getInstance();

  await Hive.initFlutter();
  MainFunctions.hiveRegisterAdapters();

  // notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();12345678
  // await LocalNotifications.localNotificationsItialization(
  //     flutterLocalNotificationsPlugin);
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      "resource://drawable/not_ic_launcher",
      [
        NotificationChannel(
          channelGroupKey: 'habits_channel_group',
          channelKey: 'habits_channel',
          channelName: 'Habits Notifications',
          channelDescription: 'Notification channel for habits',
          importance: NotificationImportance.High,
          criticalAlerts: true,
          defaultColor: Colors.transparent,
          ledColor: Colors.transparent,
        ),
        NotificationChannel(
            channelGroupKey: 'quotes_channel_group',
            channelKey: 'quotes_channel',
            groupKey: 'quotes_channel_group',
            channelName: 'Quotes Notifications',
            channelDescription: 'Notification channel for quotes',
            importance: NotificationImportance.High,
            criticalAlerts: true,
            defaultColor: Colors.transparent,
            ledColor: Colors.transparent),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'habits_channel_group',
            channelGroupName: 'Habits Group'),
        NotificationChannelGroup(
            channelGroupKey: 'quotes_channel_group',
            channelGroupName: 'Quotes Group')
      ],
      debug: true);
  MainFunctions.quotesNotif();
 
  runApp(const MyApp());
  if (currentUser != null) {
    MainFunctions.getcurrentUserInfos();
  }
  MainFunctions.askOptmiz();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale("en"),
        translations: MyLocale(),
        title: 'Smart Steps',
        theme: ThemeData(
          timePickerTheme: TimePickerThemeData(
            dialBackgroundColor: whiteColor,
            dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? orangeColor
                    : purpleTextColor),
            dayPeriodColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? orangeColor.withOpacity(0.2)
                    : purpleTextColor.withOpacity(0.2)),
            dayPeriodBorderSide: BorderSide.none,
            hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? orangeColor
                    : purpleTextColor),
            hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? orangeColor.withOpacity(0.2)
                    : purpleTextColor.withOpacity(0.2)),
            dialHandColor: orangeColor,
            dialTextColor: purpleTextColor,
            entryModeIconColor: orangeColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: purpleTextColor, width: 2),
            ),
          ),
          textTheme: const TextTheme(
              bodySmall: TextStyle(
            overflow: TextOverflow.clip,
          )),
          primarySwatch: Colors.orange,
        ),
        defaultTransition: Transition.cupertino,
        getPages: [
          GetPage(
              name: "/",
              page: () => const HomeScreen(),
              binding: HomeScreenBinding()),
          GetPage(
              name: "/NewHabit",
              page: () => const NewHabit(),
              binding: NewHabitBinding()),
          GetPage(
              name: "/VideosOverview",
              page: () => const VideosOverview(),
              binding: VideosBinding()),
          GetPage(
              name: "/SignIn",
              page: () => const SignIn(),
              binding: SignInBinding(),
              middlewares: [AuthMiddleware()]),
          GetPage(
              name: "/SignUp",
              page: () => const SignUp(),
              binding: SignUpBinding()),
          GetPage(
              name: "/EmailVerification",
              page: () => const EmailVerification(),
              binding: EmailVerificationBinding()),
          GetPage(
              name: "/Settings",
              page: () => const SettingsScreen(),
              binding: EmailVerificationBinding()),
          GetPage(
              transition: Transition.cupertino,
              name: "/ModifyProfile",
              page: () => const ModifyProfile(),
              binding: ModifyProfileBinding()),
          GetPage(
              name: "/QuizScreen",
              page: () => const QuizScreen(),
              binding: QuizScreenBinding()),
          GetPage(
            name: "/Rewards",
            page: () => const Rewards(),
          ),
          GetPage(
            name: "/OnBoarding",
            page: () => const OnBoarding(),
          ),
        ],
        initialRoute: "/SignIn"
        //  MainFunctions.isLoggedIn == false ? "/SignIn" : "/"
        // notificationAppLaunchDetails!.didNotificationLaunchApp
        //     ? "/NewHabit"
        //     : "/",
        );
  }
}

class MainFunctions {
  static File? pickedImage;
  static SharedPreferences? sharredPrefs;

  static Color generatePresizedColor(int namelength) {
    return profilColors[((namelength - 3) % 8).floor()];
  }

  static hiveRegisterAdapters() {
    Hive.registerAdapter(TimeOfDayAdapter());
    Hive.registerAdapter(ReminderModelAdapter());
    Hive.registerAdapter(DayModelAdapter());
    Hive.registerAdapter(HabitModelAdapter());
  }

  static bool isLoggedIn = false;

  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Get.closeCurrentSnackbar();

        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      Get.defaultPopGesture;
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
            duration: const Duration(minutes: 1),
            message: "noConnection".tr,
            showProgressIndicator: true,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(
              Icons.report_problem,
              color: Colors.white,
            ));
      }

      return false;
    }
  }

  static somethingWentWrongSnackBar([String? errorText]) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          duration: const Duration(seconds: 5),
          message: errorText ?? "somethingWentWrong".tr,
          showProgressIndicator: true,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ));
    }
  }

  static successSnackBar(String text) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          isDismissible: false,
          duration: const Duration(seconds: 3),
          message: text,
          backgroundColor: Colors.greenAccent,
          showProgressIndicator: true,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.done,
            color: whiteColor,
          ));
    }
  }

  static getcurrentUserInfos() async {
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

    print(currentUserInfos.currentUserImageURL);
    print("*/*/*//*/*/*/");
  }

  static List quotesList = [
    {
      "who": "-Seth Godin",
      "content":
          "“The only thing worse than starting something and failing...is not starting something.”"
    },
    {
      "who": "-Richard Bach",
      "content":
          "“The more I want to get something done the less I call it work.”"
    },
    {
      "who": "-Eleanor Roosevelt",
      "content": "“It takes as much energy to wish as it does to plan.”"
    },
    {
      "who": "-Karen Lamb",
      "content": "“A year from now you may wish you had started today.”"
    },
    {
      "who": "-Robert Collier",
      "content":
          "“Success is the sum of small efforts repeated day in and day out.”"
    },
    {
      "who": "-Muhammad Ali",
      "content": "“Don’t count the days. Make the days count.”"
    },
    {
      "who": "-Martin Luther King Jr.",
      "content": "“The time is always right to do what is right.”"
    },
  ];
  

  static quotesNotif() {
    print(sharredPrefs?.getString("firstTimeOpenApp"));
    if (sharredPrefs?.getString("firstTimeOpenApp") == null) {
      for (var i = 0; i < quotesList.length; i++) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
              category: NotificationCategory.Message,
              backgroundColor: transparentColor,
              id: i + 1,
              channelKey: 'quotes_channel',
              groupKey: 'quotes_channel_group',
              title: quotesList[i]["who"],
              body: quotesList[i]["content"],
              notificationLayout: NotificationLayout.BigText,
            ),
            schedule: NotificationCalendar(
                weekday: i + 1,
                hour: 08,
                minute: 00,
                second: 0,
                millisecond: 0,
                repeats: true));
      }

      print('/*/*/*/*/*/ created notu *//*/*///*/*/*/');
    }
  }

  static askOptmiz() {
    OptimizeBattery.isIgnoringBatteryOptimizations().then((onValue) {
      if (onValue) {
        // Igonring Battery Optimization
      } else {
        Get.defaultDialog(
          title: "Please Restrict Battery Optimization For The App",
          content: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();

                    OptimizeBattery.openBatteryOptimizationSettings();
                  },
                  child: const Text("OK")),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
            ],
          ),
        );
      }
    });
  }
}
