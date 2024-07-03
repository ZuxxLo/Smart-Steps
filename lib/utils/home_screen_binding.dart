import 'package:get/get.dart';
import 'package:momentum/Controller/home_screen_controller.dart';

class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
  }
}
