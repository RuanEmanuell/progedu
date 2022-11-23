import 'package:alarme/models/questions2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controller/controller.dart';
import '../../main.dart';
import '../../widgets/login/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/login/mainbutton.dart';

class ExerciceScreen extends StatelessWidget {
  var index;

  ExerciceScreen({required this.index});

  var anwserController = TextEditingController();

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Provider.of<Controller>(context, listen: false).controller = anwserController;

    var firebaseRef = FirebaseFirestore.instance.collection(user!.uid).doc(index.toString());

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
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Center(
                  child: Text("${quizes2[index].toUpperCase()} - EXERCISE ${value.questionCount + 1}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vt323(
                          fontSize: screenWidth / 11, color: const Color.fromARGB(255, 0, 255, 8))),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Center(
                  child: Text(questions2[quizes2[index]][value.questionCount]["question"],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vt323(
                          fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Center(
                  child: Text("Hint: ${questions2[quizes2[index]][value.questionCount]["hint"]}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vt323(
                          fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
                ),
              ),
              SizedBox(height: screenHeight / 60),
              Container(
                margin: const EdgeInsets.all(20),
                height: screenHeight / 4,
                width: screenWidth,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    value.correct
                        ? Text(value.correctTextController ? "You are right!" : "You are wrong!...",
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 10, color: value.correctColorController))
                        : Container(),
                    SizedBox(height: value.correct ? screenHeight / 60 : 0),
                    value.correct
                        ? Text("Your input:",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15, color: value.correctColorController))
                        : Text(questions2[quizes2[index]][value.questionCount]["codebox1"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15,
                                color: value.correct
                                    ? value.correctColorController
                                    : const Color.fromARGB(255, 166, 255, 0))),
                    Text(value.awnserText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.vt323(
                            fontSize: screenWidth / 15,
                            color: value.correct ? value.correctColorController : Colors.white)),
                    SizedBox(height: value.correct ? screenHeight / 30 : 0),
                    value.correct
                        ? Text("The anwser is:",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15, color: value.correctColorController))
                        : Text(questions2[quizes2[index]][value.questionCount]["codebox2"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15,
                                color: value.correct
                                    ? value.correctColorController
                                    : const Color.fromARGB(255, 166, 255, 0))),
                    value.correct
                        ? Text(questions2[quizes2[index]][value.questionCount]["anwser"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15, color: value.correctColorController))
                        : Container()
                  ],
                ),
              ),
              SizedBox(height: screenHeight / 60),
              InputWidget(
                controller: anwserController,
                value: value,
                hintText: "Type your anwser...",
              ),
              SizedBox(
                height: screenHeight / 7.5,
                child: MainButton(
                    onPressed: () async {
                      if (value.tappable && anwserController.text.isNotEmpty) {
                        if (questions2[quizes2[index]][value.questionCount]["anwser"] ==
                            value.awnserText) {
                          value.correctQuestion();
                        }
                        if (value.questionCount < questions2[quizes2[index]].length - 1) {
                          value.showCorrect();
                          value.passQuestion();
                        } else {
                          value.showCorrect();
                          var firebaseCompleteRef = await FirebaseFirestore.instance
                              .collection(user!.uid)
                              .doc("complete$index")
                              .get();
                          var firebaseCompleteRef2 = await FirebaseFirestore.instance
                              .collection(user!.uid)
                              .doc("complete$index 2")
                              .get();
                          if (firebaseCompleteRef.exists && !firebaseCompleteRef2.exists) {
                            firebaseRef.set({quizes2[index]: "100"});
                            FirebaseFirestore.instance
                                .collection(user!.uid)
                                .doc("complete$index 2")
                                .set({"complete": "completed"});
                          }
                          FirebaseFirestore.instance
                              .collection("quizrankings")
                              .doc(("${value.correctCount.toString()} ${user!.displayName}"))
                              .set({"name": user!.displayName, "rank": value.correctCount.toString()});
                          value.tappable = true;
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return MyApp();
                              },
                            ));
                          });
                        }
                        anwserController.text = "";
                      }
                    },
                    text: "Submit"),
              )
            ],
          ));
        }));
  }
}
