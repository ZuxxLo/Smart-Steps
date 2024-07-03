import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunityPostModel {
  late String postID;
  late String posterUID;
  late String posterName;
  late String posterImage;
  late String title;
  late String content;
  late Timestamp postDate;
  late int likesCounter;
  late Color likeColor;
  late bool likeExists;
  late int commentsCounter;

  CommunityPostModel({
    required this.postID,
    required this.posterUID,
    required this.posterName,
    required this.posterImage,
    required this.title,
    required this.content,
    required this.postDate,
    required this.likesCounter,
    required this.likeColor,
    required this.likeExists,
    required this.commentsCounter,
  });
}
