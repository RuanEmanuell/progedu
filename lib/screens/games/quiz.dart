import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../main.dart';
import '../../models/questions1.dart';
import '../../widgets/general/appbar.dart';
import '../../widgets/general/text.dart';

class QuizScreen extends StatelessWidget {
  final dynamic index;

  QuizScreen({super.key, required this.index});

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var firebaseRef = FirebaseFirestore.instance.collection(user!.uid).doc(index.toString());

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 15), child: CustomAppBar()),
        body: Consumer<Controller>(builder: (context, value, child) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: screenHeight / 15, top: screenHeight / 15),
                      child: CustomText(
                          text: "${quizes[index]} - question ${value.questionCount + 1}".toUpperCase(),
                          fontSize: screenWidth / 10)),
                  Container(
                      margin: EdgeInsets.only(left: screenWidth / 30, right: screenWidth / 30),
                      child: CustomText(
                          text: questions[quizes[index]][value.questionCount]["question"],
                          fontSize: screenWidth / 15)),
                  Container(
                    margin: EdgeInsets.only(
                        top: screenHeight /
                            questions[quizes[index]][value.questionCount]["anwsers"].length /
                            4),
                    height: screenHeight,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: questions[quizes[index]][value.questionCount]["anwsers"].length,
                      itemBuilder: (context, listIndex) {
                        return InkWell(
                          onTap: () async {
                            if (value.tappable) {
                              if (questions[quizes[index]][value.questionCount]["anwsers"][listIndex] ==
                                  questions[quizes[index]][value.questionCount]["correct"]) {
                                value.correctQuestion();
                              }
                              if (value.questionCount < questions[quizes[index]].length - 1) {
                                value.showCorrect();
                                value.passQuestion();
                              } else {
                                value.showCorrect();
                                var firebaseCompleteRef = await FirebaseFirestore.instance
                                    .collection(user!.uid)
                                    .doc("complete$index")
                                    .get();
                                if (!firebaseCompleteRef.exists) {
                                  firebaseRef.set({quizes[index]: "50"});
                                  FirebaseFirestore.instance
                                      .collection(user!.uid)
                                      .doc(("complete$index").toString())
                                      .set({"complete": "completed"});
                                }
                                value.tappable = true;
                                FirebaseFirestore.instance
                                    .collection("quizrankings")
                                    .doc(("${value.correctCount.toString()} ${user!.displayName}"))
                                    .set({
                                  "name": user!.displayName,
                                  "rank": value.correctCount.toString()
                                });
                                Future.delayed(const Duration(seconds: 3), () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return MyApp();
                                    },
                                  ));
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(10),
                            width: screenWidth,
                            decoration: BoxDecoration(
                                color: questions[quizes[index]][value.questionCount]["anwsers"]
                                                [listIndex] ==
                                            questions[quizes[index]][value.questionCount]["correct"] &&
                                        value.correct
                                    ? Colors.green
                                    : Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                questions[quizes[index]][value.questionCount]["anwsers"][listIndex],
                                style: GoogleFonts.vt323(
                                  fontSize: screenWidth / 20,
                                  color: questions[quizes[index]][value.questionCount]["anwsers"]
                                                  [listIndex] ==
                                              questions[quizes[index]][value.questionCount]["correct"] &&
                                          value.correct
                                      ? Colors.white
                                      : const Color.fromARGB(255, 0, 255, 8),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                top: screenHeight / 1.16,
                child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: screenHeight / 50,
                    width: value.questionCount * screenWidth / questions[quizes[index]].length,
                    color: Colors.green),
              ),
            ]),
          );
        }));
  }
}
