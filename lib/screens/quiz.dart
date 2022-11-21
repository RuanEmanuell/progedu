import 'package:alarme/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../controller/controller.dart';
import '../models/questions1.dart';

class QuizScreen extends StatelessWidget {
  var index;

  QuizScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 27, 27, 27),
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text("/ProgEdu",
                style: GoogleFonts.vt323(
                    fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
            actions: [
              IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close,
                      size: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
            ]),
        body: Consumer<Controller>(builder: (context, value, child) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight / 15, top: screenHeight / 15),
                    child: Text(
                      "${quizes[index]} - question ${value.questionCount + 1}".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vt323(
                          fontSize: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth / 30, right: screenWidth / 30),
                    child: Text(
                      questions[quizes[index]][value.questionCount]["question"],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vt323(
                          fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8)),
                    ),
                  ),
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
                          onTap: () {
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
                                FirebaseFirestore.instance
                                    .collection(user!.uid)
                                    .doc(index.toString())
                                    .set({quizes[index]: "50"});
                                Future.delayed(const Duration(seconds: 3), () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return HomeScreen();
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
