import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/Controller/videos_controller.dart';
import 'package:momentum/View/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosOverview extends StatelessWidget {
  const VideosOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final VideosController videosController = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<VideosController>(builder: (context) {
      if (videosController.youtubeController == null) {
        return const CircularProgressIndicator(
              color: orangeColor,
            );
      } else {
        return YoutubePlayerBuilder(
              player: YoutubePlayer(
                  controller: videosController.youtubeController!),
              builder: (context, player) {
                return Scaffold(
                  backgroundColor: transparentColor,
                  resizeToAvoidBottomInset: false,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  appBar: AppBar(
                    leadingWidth: 70,
                    elevation: 0,
                    backgroundColor: backgroundColor,
                    centerTitle: true,
                    title: Text(
                      "Motivational video",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: purpleTextColor),
                    ),
                   
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(right: 17, left: 17),
                    child: Container(
                        key: UniqueKey(),
                        decoration: const BoxDecoration(color: whiteColor),
                        child: GetBuilder<VideosController>(builder: (context) {
                          return player;
                        })),
                  ),
                );
              });
      }
    });
  }
}
