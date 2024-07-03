import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  @override
  RouteSettings? redirect(String? route) {
    
    if (MainFunctions.sharredPrefs?.getString("firstTimeOpenApp") == null) {
      return const RouteSettings(name: "/OnBoarding");
    } else if (currentUser != null && currentUser!.emailVerified) {
      MainFunctions.getcurrentUserInfos();
      return const RouteSettings(name: "/");
    } else {
      return null;
    }
  }
}
