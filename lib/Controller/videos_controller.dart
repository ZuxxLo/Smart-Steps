import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosController extends GetxController {
  static List vids = [];

  getVideos() async {
    await FirebaseFirestore.instance.collection('videos').get().then((value) {
      vids = value.docs;
    });
    youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(vids.last['videoURL'])!,
        flags: const YoutubePlayerFlags(autoPlay: false));
    update();
  }

  YoutubePlayerController? youtubeController;

  searchVideo(int videoTitle) {
    print("sdsdqsdqsdsqdqsqs");

    youtubeController
        !.load(YoutubePlayer.convertUrlToId(vids[videoTitle]['videoURL'])!);
    print(vids[videoTitle]['videoURL']);
    update();
  }

  @override
  void onInit() {
    print("0000000");
    getVideos();

    super.onInit();
  }
}
