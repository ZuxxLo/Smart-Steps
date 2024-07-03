import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/View/colors.dart';
import 'package:momentum/View/widgets.dart';

import '../Controller/settings_controller.dart';

class Rewards extends StatelessWidget {
  const Rewards({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyCustomAppBar(
          title: "Rewards",
          screenWidth: screenWidth,
          iconAction: null,
          iconLeading: Icons.arrow_back_ios_new_outlined,
          function: () {
            Get.back();
          }),
      backgroundColor: backgroundColor,
      body: FutureBuilder(
        future: settingsController.loadBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GetBuilder<SettingsController>(builder: (context) {
              return ListView.builder(
                itemCount: settingsController.booksList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(settingsController.booksList[index]["title"] , style: const TextStyle(fontSize: 17),),
                    subtitle: Text(
                        "Cost :${settingsController.booksList[index]["cost"]}"),
                    trailing: IconButton(
                        onPressed: () {settingsController.downloadBook(index);},
                        icon:const Icon(
                          Icons.download_for_offline_outlined,
                          color: purpleTextColor,
                        )),
                  );
                },
              );
            });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
