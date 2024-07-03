import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/Model/community_post_model.dart';
import '../View/colors.dart';
import '../main.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class CommunityController extends GetxController {
  // List<QueryDocumentSnapshot<Map<String, dynamic>>> communityPostsDocs = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> communityPostsCommentsDocs =
      [];
  Map<String, CommunityPostModel> communityPostsDocs = {};
  getPostsDocs() async {
    if (await MainFunctions.checkInternetConnection()) {
      await FirebaseFirestore.instance
          .collection('community posts')
          .get()
          .then((value) async {
        // communityPostsDocs = value.docs;
        for (int index = 0; index < value.docs.length; index++) {
          communityPostsDocs.addAll({
            value.docs[index].id: CommunityPostModel(
                postID: value.docs[index].id,
                posterUID: value.docs[index]["posterUID"],
                posterName: value.docs[index]["posterName"],
                posterImage: value.docs[index]["posterImage"],
                title: value.docs[index]["title"],
                content: value.docs[index]["content"],
                postDate: value.docs[index]["postDate"],
                likesCounter: value.docs[index]["likesCounter"],
                likeColor: orangeColor,
                likeExists: false,
                commentsCounter: value.docs[index]["commentsCounter"])
          });

          if (await ifexist(communityPostsDocs.values.elementAt(index).postID,
              currentUser!.uid)) {
            communityPostsDocs.values.elementAt(index).likeColor =
                purpleTextColor;
            communityPostsDocs.values.elementAt(index).likeExists = true;
          }
        }
      });
    }

    update();
  }

  noccn() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getPostsDocs();
      if (communityPostsDocs.isNotEmpty) {
        timer.cancel();
      }
    });
    update();
  }

  getPostsCommentsDocs(String postDoctumentUID) async {
    await FirebaseFirestore.instance
        .collection('community posts')
        .doc(postDoctumentUID)
        .collection("comments")
        .get()
        .then((value) {
      communityPostsCommentsDocs = value.docs;
    });
    for (var element in communityPostsCommentsDocs) {
      print(element.get("commentContent"));
    }

    update();
  }

  Color getRightColor(int index, bool exists) {
    if (exists) {
      return purpleTextColor;
    } else {
      return orangeColor;
    }
  }

  Future<bool> ifexist(String postDoctumentUID, String userUID) async {
    var x = await FirebaseFirestore.instance
        .collection("community posts")
        .doc(postDoctumentUID)
        .collection("likes")
        .doc(userUID)
        .get();

    return x.exists;
  }

  likeApost(String postDoctumentUID, String userUID, int index) async {
    if (communityPostsDocs.values.elementAt(index).likeExists) {
      communityPostsDocs.values.elementAt(index).likesCounter--;
      communityPostsDocs.values.elementAt(index).likeColor = orangeColor;
      communityPostsDocs.values.elementAt(index).likeExists = false;

      FirebaseFirestore.instance
          .collection("community posts")
          .doc(postDoctumentUID)
          .collection("likes")
          .doc(userUID)
          .delete();

      FirebaseFirestore.instance
          .collection("community posts")
          .doc(postDoctumentUID)
          .update({"likesCounter": FieldValue.increment(-1)});
    } else {
      communityPostsDocs.values.elementAt(index).likesCounter++;
      communityPostsDocs.values.elementAt(index).likeColor = purpleTextColor;
      communityPostsDocs.values.elementAt(index).likeExists = true;

      FirebaseFirestore.instance
          .collection("community posts")
          .doc(postDoctumentUID)
          .collection("likes")
          .doc(userUID)
          .set({
        "likerImage": currentUser!.photoURL,
        "likerName": currentUser!.displayName,
      });
      FirebaseFirestore.instance
          .collection("community posts")
          .doc(postDoctumentUID)
          .update({"likesCounter": FieldValue.increment(1)});
    }

    update();
  }

  // var washingtonRef =
  //     FirebaseFirestore.instance.collection('cities').doc('DC');
  // washingtonRef.update(
  //   {"population": FieldValue.increment(50)},
  // );
  String readTimestampDate(Timestamp timestamp) {
    DateFormat format = DateFormat('HH:mm, MMM d, y');
    return format.format(DateTime.parse(timestamp.toDate().toString()));
  }


  Color generatePresizedColor(int namelength) {
    return profilColors[((namelength - 3) % 8).floor()];
  }

  @override
  void onInit() async {
    getPostsDocs();
    super.onInit();
  }
}
