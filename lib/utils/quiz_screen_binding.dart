import 'package:get/get.dart';

import '../Controller/quiz_screen_controller.dart';
 
 
class QuizScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(QuizScreenController());
  }
}