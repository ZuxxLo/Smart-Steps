import 'package:get/get.dart';

import '../Controller/verify_email_controller.dart';

class EmailVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EmailVerificationController());
  }
}
