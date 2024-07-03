import 'package:firebase_messaging/firebase_messaging.dart';

class Apis {
  static FirebaseMessaging Fmessaging = FirebaseMessaging.instance;

  static getFirebaseMessagingToken() async {
    await Fmessaging.requestPermission();
    await Fmessaging.getToken().then(
      (value) {
        if (value != null) {
          print(value);
        }
      },
    );
  }
}
