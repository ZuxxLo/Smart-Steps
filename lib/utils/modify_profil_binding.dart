import 'package:get/get.dart';
 import 'package:momentum/Controller/modify_profil_controller.dart';

class ModifyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ModifyProfileController());
  }
}
