
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:momentum/Controller/community_controller.dart';
import 'package:momentum/View/colors.dart';
import 'package:momentum/View/widgets.dart';

import '../main.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunityController communityController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: null,
      backgroundColor: transparentColor,
      appBar: MyCustomAppBar(
          title: "Community".tr,
          screenWidth: screenWidth,
          iconAction: null,
          iconLeading: null,
          function: () {}),
      body: GetBuilder<CommunityController>(builder: (context) {
        if (communityController.communityPostsDocs.isEmpty) {
          communityController.noccn();
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: communityController.communityPostsDocs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: whiteColor),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 45,
                                width: 45,
                                child: communityController
                                            .communityPostsDocs.values
                                            .elementAt(index)
                                            .posterImage ==
                                        ""
                                    ? CircleAvatar(
                                        backgroundColor: communityController
                                            .generatePresizedColor(
                                                communityController
                                                    .communityPostsDocs.values
                                                    .elementAt(index)
                                                    .posterName
                                                    .length),
                                        child: Text(
                                          communityController
                                              .communityPostsDocs.values
                                              .elementAt(index)
                                              .posterName[0].toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 27,
                                              color: purpleTextColor),
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            communityController
                                                .communityPostsDocs.values
                                                .elementAt(index)
                                                .posterImage),
                                      ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      communityController
                                          .communityPostsDocs.values
                                          .elementAt(index)
                                          .posterName,
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.05),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      communityController
                                          .communityPostsDocs.values
                                          .elementAt(index)
                                          .title,
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              PopupMenuButton<int>(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {},
                                    value: 1,
                                    child: const Text("ticket"),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {},
                                    value: 2,
                                    child: const Text("ordonnace"),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Divider(
                            color: purpleTextColor,
                            thickness: 0.5,
                          ),
                          Text(
                            communityController.communityPostsDocs.values
                                .elementAt(index)
                                .content,
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                communityController.readTimestampDate(
                                    communityController
                                        .communityPostsDocs.values
                                        .elementAt(index)
                                        .postDate),
                                style: const TextStyle(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                      style: ButtonStyle(
                                          overlayColor: communityController
                                                  .communityPostsDocs.values
                                                  .elementAt(index)
                                                  .likeExists
                                              ? MaterialStateProperty.all(
                                                  purpleTextColor
                                                      .withOpacity(0.2))
                                              : MaterialStateProperty.all(
                                                  orangeColor
                                                      .withOpacity(0.2))),
                                      onPressed: () {
                                        communityController.likeApost(
                                            communityController
                                                .communityPostsDocs.values
                                                .elementAt(index)
                                                .postID,
                                            currentUser!.uid,
                                            index);
                                      },
                                      icon: Icon(
                                        Icons.thumb_up_alt,
                                        color: communityController
                                            .communityPostsDocs.values
                                            .elementAt(index)
                                            .likeColor,
                                      ),
                                      label: Text(
                                        communityController
                                            .communityPostsDocs.values
                                            .elementAt(index)
                                            .likesCounter
                                            .toString(),
                                        style: TextStyle(
                                          color: communityController
                                              .communityPostsDocs.values
                                              .elementAt(index)
                                              .likeColor,
                                        ),
                                      )),
                                  TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.comment),
                                      label: Text(communityController
                                          .communityPostsDocs.values
                                          .elementAt(index)
                                          .commentsCounter
                                          .toString()))
                                ],
                              ),
                            ],
                          )
                        ]),
                  ),
                );
              });
        }
      }),
    );
  }
}
