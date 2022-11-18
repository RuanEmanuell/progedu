import 'package:alarme/screens/home.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

import "../models/questions.dart";

class QuizScreen extends StatelessWidget {
  var index;

  QuizScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  questions[quizes[index]][value.questionCount]["question"],
                  style: GoogleFonts.vt323(
                      fontSize: screenWidth / 22, color: const Color.fromARGB(255, 0, 255, 8)),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: questions[quizes[index]][value.questionCount]["anwsers"].length,
                itemBuilder: (context, listIndex) {
                  return InkWell(
                    onTap: () {
                      if (value.questionCount < questions[quizes[index]].length - 1) {
                        value.showCorrect();
                        questions[quizes[index]][value.questionCount]["anwsers"][listIndex] ==
                                questions[quizes[index]][value.questionCount]["correct"]
                            ? value.correctQuestion()
                            : false;
                        value.passQuestion();
                      } else {
                        value.showCorrect();
                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ));
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: questions[quizes[index]][value.questionCount]["anwsers"][listIndex] ==
                                      questions[quizes[index]][value.questionCount]["correct"] &&
                                  value.correct
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          questions[quizes[index]][value.questionCount]["anwsers"][listIndex],
                          style: GoogleFonts.vt323(
                              fontSize: screenWidth / 22, color: const Color.fromARGB(255, 0, 255, 8)),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        }));
  }
}
