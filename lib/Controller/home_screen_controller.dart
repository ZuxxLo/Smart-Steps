import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:momentum/Controller/settings_controller.dart';
import 'package:momentum/Controller/videos_controller.dart';
import '../Model/day_model.dart';
import '../Model/habit_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../main.dart';

class HomeScreenController extends GetxController {
  int _currentBottomBarIndex = 0;
  late Box<HabitModel> habitsBox;
  List<HabitModel> habitsOfSelectedDay = [];
  int? selectedDay;

  int currentBottomBarIndex() {
    return _currentBottomBarIndex;
  }

  switchBetweenScreens(index) async {
    if (index == 0) {
      _currentBottomBarIndex = index;
    }
    if (index == 1) {
      // Apis.getFirebaseMessagingToken();
    }

    if (index == 1 && await MainFunctions.checkInternetConnection()) {
      Get.put(VideosController());
      _currentBottomBarIndex = index;
    }

    if (index == 2) {
      if (currentUser != null ) {
        MainFunctions.checkInternetConnection();
        MainFunctions.getcurrentUserInfos();
        Get.put(SettingsController());
        _currentBottomBarIndex = index;
      }
    }

    update();
  }

  int daySelectedinWeekList(List<DayModel> weekList, int daySelected) {
    return weekList
        .indexWhere((DayModel dayElement) => dayElement.day == daySelected);
  }

  getHabits(int day) {
    print("tapped day $day");

    // if (day == 6) {
    //   selectedDay = 0;
    // } else if (day == 7) {
    //   selectedDay = 1;
    // } else {
    //   selectedDay = day + 1;
    // }

    habitsOfSelectedDay.clear();
    habitsBox.toMap().forEach((key, value) {
      for (DayModel dayElement in value.weekList) {
        if (dayElement.day == day && dayElement.frequency > 0) {
          habitsOfSelectedDay.add(value);
          selectedDay = daySelectedinWeekList(value.weekList, day);
        }
      }
    });
    update();
  }

  deleteAllHabits() {
    // AwesomeNotifications().cancelAll();
    // AwesomeNotifications().cancelAllSchedules();
    AwesomeNotifications().cancelNotificationsByChannelKey('habits_channel');
    habitsBox.clear();
    habitsOfSelectedDay.clear();
    MainFunctions.successSnackBar("All habits were deleted successfully");
  }

  int concatenate2Numbers(int a, int b, int c) {
    return int.parse(a.toString() + b.toString() + c.toString());
  }

  @override
  onInit() async {
    print("**************************");
    await Hive.openBox<HabitModel>("habitsBox");
    habitsBox = Hive.box<HabitModel>("habitsBox");
    getHabits(DateTime.now().weekday);

    update();

    super.onInit();
  }
}
