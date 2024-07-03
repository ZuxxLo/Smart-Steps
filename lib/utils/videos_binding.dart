import 'package:get/get.dart';
import 'package:momentum/Controller/videos_controller.dart';
 
class VideosBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(VideosController());
  }
}
