import 'package:get/get.dart';
import 'package:momentum/Controller/sign_in_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
