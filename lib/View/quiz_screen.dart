import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/quiz_screen_controller.dart';
import 'colors.dart';
import 'package:momentum/View/widgets.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizScreenController quizScreenController = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyCustomAppBar(
          title: "Quiz",
          screenWidth: screenWidth,
          iconAction: null,
          iconLeading: Icons.arrow_back_ios_new,
          function: () {
            Get.back();
          }),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // top padding
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [NumberOfQuestions(), PlayerScore()],
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              // GetBuilder<QuizScreenController>(builder: (context) {
              //   for (var i = 0; i < 10; i++) {
              //     return TweenAnimationBuilder(
              //       duration: Duration(
              //           seconds:
              //               quizScreenController.getSecondsLeftToAnswer +
              //                   1),
              //       tween: quizScreenController.tween,
              //       builder: (BuildContext context, double value,
              //           Widget? child) {
              //         return CircularProgressIndicator(
              //           value: value,
              //           strokeWidth: 2,
              //           color: Colors.black ,
              //         );
              //       },
              //     );
              //   }
              //   return Text("data");
              // }),
              GetBuilder<QuizScreenController>(builder: (context) {
                return (quizScreenController.getNumberOfQuestions + 1 == 10 &&
                        quizScreenController.getSecondsLeftToAnswer
                                .toDouble() ==
                            0)
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                      )
                    : CircularProgressIndicator(
                        value: quizScreenController.getSecondsLeftToAnswer
                                .toDouble() /
                            10,
                        strokeWidth: 2,
                      );
              }),
              GetBuilder<QuizScreenController>(builder: (context) {
                return Text(
                    quizScreenController.getSecondsLeftToAnswer.toString());
              }),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.035,
          ),
          SizedBox(
            height: screenHeight * 0.62,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 7,
                  child: GetBuilder<QuizScreenController>(builder: (context) {
                    return PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: quizScreenController.pageController,
                      itemCount: quizScreenController.getQuestionList.length,
                      itemBuilder: (BuildContext context, int indexx) =>
                          SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                quizScreenController
                                    .getQuestionList[indexx].question,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: screenWidth * 0.06,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              direction: Axis.vertical,
                              spacing: screenHeight * 0.04,
                              children: List<Widget>.generate(
                                4,
                                (index) => GetBuilder<QuizScreenController>(
                                    builder: (context) {
                                  return TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 3,
                                          color: quizScreenController
                                              .getRightColor(index),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                    ),
                                    onPressed: () {
                                      if (quizScreenController.getIsPressed) {
                                      } else {
                                        // so that no one spam
                                        quizScreenController.setIsPressed =
                                            true;
                                        // get user's answer to compare it
                                        quizScreenController.setUserAnswer =
                                            index;

                                        quizScreenController.toNextQuestion();
                                        quizScreenController
                                            .playerScoreIncrement(index);
                                      }
                                    },
                                    //the option from the question model
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: screenWidth * 0.8,
                                      height: screenHeight * 0.05,
                                      child: Text(
                                        quizScreenController
                                            .getQuestionList[indexx]
                                            .options[index],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenWidth * 0.05,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ), //skip and score button
              ],
            ),
          ),
          GetBuilder<QuizScreenController>(builder: (context) {
            return MyButton(
                height: screenHeight * 0.07,
                width: screenWidth * 0.5,
                title: quizScreenController.getNumberOfQuestions == 9
                    ? "Finish ! "
                    : "Skip",
                function: () {
                  if (quizScreenController.getSkipIsPressed) {
                  } else {
                    // so that no one spam
                    quizScreenController.setSkipIsPressed = true;

                    quizScreenController.toNextQuestion();
                  }
                });
          })
        ]),
      ),
    );
  }
}

class NumberOfQuestions extends StatelessWidget {
  NumberOfQuestions({
    Key? key,
  }) : super(key: key);
  final QuizScreenController quizScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<QuizScreenController>(builder: (context) {
          return Text(
            "${quizScreenController.getNumberOfQuestions + 1}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          );
        }),
        const Icon(
          Icons.question_mark,
          size: 20,
        ),
      ],
    );
  }
}

class PlayerScore extends StatelessWidget {
  PlayerScore({
    Key? key,
  }) : super(key: key);
  final QuizScreenController quizScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<QuizScreenController>(builder: (context) {
          return Text(
            quizScreenController.getPlayerScore.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          );
        }),
        const Icon(
          Icons.auto_awesome,
          size: 20,
        ),
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.function,
  }) : super(key: key);
  final double height;
  final double width;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 64, 25, 157),
              Color.fromARGB(255, 52, 1, 172),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: ElevatedButton(
            onPressed: () {
              function();
            },
            child: Text(
              title,
              style: TextStyle(fontSize: width * 0.09),
            )));
  }
}
