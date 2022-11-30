import '../../models/questions2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controller/controller.dart';
import '../../main.dart';
import '../../models/strings.dart';
import '../../widgets/general/appbar.dart';
import '../../widgets/general/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/general/text.dart';
import '../../widgets/login/mainbutton.dart';

class ExerciceScreen extends StatefulWidget {
  final dynamic index;

  const ExerciceScreen({super.key, required this.index});

  @override
  State<ExerciceScreen> createState() => _ExerciceScreenState();
}

class _ExerciceScreenState extends State<ExerciceScreen> {
  final TextEditingController anwserController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Provider.of<Controller>(context, listen: false).controller = anwserController;

    var firebaseRef = FirebaseFirestore.instance.collection(user!.uid).doc(widget.index.toString());

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight / 15), child: const SecondaryAppBar()),
        body: Consumer<Controller>(builder: (context, value, child) {
          return SingleChildScrollView(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Center(
                    child: CustomText(
                        text:
                            "${quizes2[widget.index]} - ${strings[value.language]["exercice"]} ${value.questionCount + 1}"
                                .toUpperCase(),
                        fontSize: screenWidth / 11)),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Center(
                    child: CustomText(
                        text: questions2[value.language][quizes2[widget.index]][value.questionCount]
                            ["question"],
                        fontSize: screenWidth / 14)),
              ),
              InkWell(
                onTap: () {
                  value.showRewardedAd();
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Center(
                      child: CustomText(
                          text: value.reward
                              ? strings[value.language]["hint"] +
                                  questions2[value.language][quizes2[widget.index]][value.questionCount]
                                      ["hint"]
                              : strings[value.language]["hint"] + strings[value.language]["ad"],
                          fontSize: screenWidth / 15)),
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
                        ? Text(
                            value.correctTextController
                                ? strings[value.language]["right"]
                                : strings[value.language]["wrong"],
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 10, color: value.correctColorController))
                        : Container(),
                    SizedBox(height: value.correct ? screenHeight / 60 : 0),
                    value.correct
                        ? Text(strings[value.language]["input"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15, color: value.correctColorController))
                        : Text(
                            questions2[value.language][quizes2[widget.index]][value.questionCount]
                                ["codebox1"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15,
                                color: value.correct
                                    ? value.correctColorController
                                    : const Color.fromARGB(255, 166, 255, 0))),
                    Text(anwserController.text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.vt323(
                            fontSize: screenWidth / 15,
                            color: value.correct ? value.correctColorController : Colors.white)),
                    SizedBox(height: value.correct ? screenHeight / 30 : 0),
                    value.correct
                        ? Text(strings[value.language]["rightanwser"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15, color: value.correctColorController))
                        : Text(
                            questions2[value.language][quizes2[widget.index]][value.questionCount]
                                ["codebox2"],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 15,
                                color: value.correct
                                    ? value.correctColorController
                                    : const Color.fromARGB(255, 166, 255, 0))),
                    value.correct
                        ? Text(
                            questions2[value.language][quizes2[widget.index]][value.questionCount]
                                ["anwser"],
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
                hintText: strings[value.language]["youranwser"],
              ),
              SizedBox(
                height: screenHeight / 7.5,
                child: MainButton(
                    onPressed: () async {
                      if (value.tappable && anwserController.text.isNotEmpty) {
                        if (questions2[value.language][quizes2[widget.index]][value.questionCount]
                                ["anwser"] ==
                            anwserController.text) {
                          value.correctQuestion();
                        }
                        if (value.questionCount <
                            questions2[value.language][quizes2[widget.index]].length - 1) {
                          value.showCorrect();
                          value.passQuestion();
                          value.resetAnwser();
                        } else {
                          value.showCorrect();
                          value.resetAnwser();
                          value.resetReward();
                          value.isTappable();
                          value.showInterAd();
                          var firebaseCompleteRef = await FirebaseFirestore.instance
                              .collection(user!.uid)
                              .doc("complete${widget.index}")
                              .get();
                          var firebaseCompleteRef2 = await FirebaseFirestore.instance
                              .collection(user!.uid)
                              .doc("complete${widget.index} 2")
                              .get();
                          if (firebaseCompleteRef.exists && !firebaseCompleteRef2.exists) {
                            firebaseRef.set({quizes2[widget.index]: "100"});
                            FirebaseFirestore.instance
                                .collection(user!.uid)
                                .doc("complete${widget.index} 2")
                                .set({"complete": "completed"});
                          }
                          FirebaseFirestore.instance
                              .collection("${widget.index}exercicesrankings")
                              .doc(("${(value.correctCount - 20).toString()} ${user!.displayName}"))
                              .set({
                            "name": user!.displayName,
                            "id": user!.uid,
                            "rank": value.correctCount.toString()
                          });
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const MyApp();
                              },
                            ));
                          });
                        }
                      }
                    },
                    text: strings[value.language]["submit"]),
              )
            ],
          ));
        }));
  }
}
