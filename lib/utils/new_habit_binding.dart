import 'package:get/get.dart';
import 'package:momentum/Controller/new_habit_controller.dart';

class NewHabitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NewHabitController());
  }
}
