import 'package:get/get.dart';
import 'package:momentum/Controller/community_controller.dart';
 
class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CommunityController());
  }
}
