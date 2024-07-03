import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import '../main.dart';

class SettingsController extends GetxController {
  signOutOfAnExistingAccount() async {
    await FirebaseAuth.instance.signOut().then((value) {
      currentUser = null;

      Get.offAndToNamed("/SignIn");
    });
  }

  late bool isDarkMode;

  goToModifyProfil() {
    Get.toNamed("/ModifyProfile");
  }

  late Future<ListResult> futureBooks;
  List booksList = [];

  Future loadBooks() async {
    booksList.clear();
    var snapshot = await FirebaseFirestore.instance.collection("Books").get();
    for (var element in snapshot.docs) {
      booksList.add(element.data());
    }

    print(booksList.length);

    print("/*/*/*/*/*/");

    return snapshot;
  }

  File? file;
  downloadBook(int index) async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        //You can download a single file

        if (currentUserInfos.currentUserPoints! >= booksList[index]["cost"]) {
          FileDownloader.downloadFile(
              url: booksList[index]["link"],
              name: booksList[index]["title"],
              onProgress: (fileName, progress) {
                print(progress);
              },
              onDownloadCompleted: (String path) async {
                print('FILE DOWNLOADED TO PATH: $path');

                MainFunctions.successSnackBar("FILE DOWNLOADED TO PATH: $path");

                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(currentUser!.uid)
                    .update({
                  "Points": FieldValue.increment(-booksList[index]["cost"]),
                });

                currentUserInfos.currentUserPoints =
                    (currentUserInfos.currentUserPoints! -
                        booksList[index]["cost"]) as int?;

                update();
              },
              onDownloadError: (String error) {
                print('DOWNLOAD ERROR: $error');
              });

          MainFunctions.successSnackBar(
              "Downloading ${booksList[index]["title"]}");
        } else {
          MainFunctions.somethingWentWrongSnackBar(
              "You don't have enough points!");
        }

        update();
      }
    }

    // load file that you want to save on user's phone
    // it can be loaded from whenever you want, e.g. some API.
  }

}
