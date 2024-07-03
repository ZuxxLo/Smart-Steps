import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/Controller/home_screen_controller.dart';
import 'package:momentum/View/colors.dart';
import 'package:momentum/View/settings.dart';
import 'package:momentum/View/videos_overview.dart';
import 'tracking_habits.dart';
import 'widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController homeScreenController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<BottomNavigationBarItem> bottomNavigationBarItemList = [
      BottomNavigationBarItem(
          activeIcon: Container(
            alignment: Alignment.center,
            width: screenWidth * 0.1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.asset("images/XMLID.png"),
          ),
          icon: Container(
              foregroundDecoration: const BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
              ),
              alignment: Alignment.center,
              width: screenWidth * 0.09,
              child: Image.asset("images/XMLID.png")),
          label: "Home"),
      // BottomNavigationBarItem(
      //     activeIcon: Container(
      //       alignment: Alignment.center,
      //       width: screenWidth * 0.09,
      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      //       child: Image.asset("images/Courses.png"),
      //     ),
      //     icon: Container(
      //         foregroundDecoration: const BoxDecoration(
      //           color: Colors.grey,
      //           backgroundBlendMode: BlendMode.saturation,
      //         ),
      //         alignment: Alignment.center,
      //         width: screenWidth * 0.09,
      //         child: Image.asset("images/Courses.png")),
      //     label: "Courses"),
      BottomNavigationBarItem(
          activeIcon: Container(
            alignment: Alignment.center,
            width: screenWidth * 0.09,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.asset("images/Courses.png"),
          ),
          icon: Container(
              foregroundDecoration: const BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
              ),
              alignment: Alignment.center,
              width: screenWidth * 0.09,
              child: Image.asset("images/Courses.png")),
          label: "Courses"),
      BottomNavigationBarItem(
          activeIcon: Container(
            alignment: Alignment.center,
            width: screenWidth * 0.09,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.asset("images/Settings.png"),
          ),
          icon: Container(
              foregroundDecoration: const BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
              ),
              alignment: Alignment.center,
              width: screenWidth * 0.09,
              child: Image.asset("images/Settings.png")),
          label: "Settings"),
    ];

    const List<Widget> bottomNavigationBarScreensList = [
      TrackingHabits(),
       VideosOverview(),
      SettingsScreen(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      bottomNavigationBar: GetBuilder<HomeScreenController>(builder: (context) {
        return BottomNavigationBar(
          backgroundColor: backgroundColor,
          items: bottomNavigationBarItemList,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: homeScreenController.currentBottomBarIndex(),
          onTap: (index) {
            homeScreenController.switchBetweenScreens(index);
          },
        );
      }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
      //     BoxShadow(
      //       color: orangeColor.withOpacity(0.7),
      //       spreadRadius: 5,
      //       blurRadius: 7,
      //       offset: const Offset(0, 3),
      //     )
      //   ]),
      //   child: FloatingActionButton(
      //       elevation: 0,
      //       foregroundColor: purpleTextColor,
      //       backgroundColor: orangeColor,
      //       onPressed: () {
      //         Get.toNamed(
      //           "/NewHabit",
      //         );
      //       },
      //       child: const Icon(
      //         Icons.add,
      //         size: 30,
      //       )),
      // ),
      body: GetBuilder<HomeScreenController>(builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            const BackgroundWidget(),
            bottomNavigationBarScreensList[
                homeScreenController.currentBottomBarIndex()],
          ],
        );
      }),
    );
  }
}
