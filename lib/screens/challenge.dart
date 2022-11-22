import 'package:alarme/screens/exercices.dart';
import 'package:alarme/screens/quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../models/questions1.dart';

class ChallengeScreen extends StatefulWidget {
  var index;

  ChallengeScreen({required this.index});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  var user = FirebaseAuth.instance.currentUser;

  var firebaseCompleteRef;
  var firebaseCompleteRef2;

  checkExists() async {
    firebaseCompleteRef =
        await FirebaseFirestore.instance.collection(user!.uid).doc("complete${widget.index}").get();
    firebaseCompleteRef2 =
        await FirebaseFirestore.instance.collection(user!.uid).doc("complete${widget.index} 2").get();
  }

  @override
  void initState() {
    super.initState();
    checkExists();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

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
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Text(quizes[widget.index].toUpperCase(),
                    style: GoogleFonts.vt323(
                        fontSize: screenWidth / 7.5, color: const Color.fromARGB(255, 0, 255, 8))),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: screenHeight / 10,
                width: screenWidth,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        opacity: 0.3,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/${widget.index}.png"))),
                child: InkWell(
                  onTap: () {
                    value.questionCount = 0;
                    value.correctCount = 0;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return QuizScreen(index: widget.index);
                      },
                    ));
                  },
                  child: Center(
                    child: Text("Challenge 1 - Quiz",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.vt323(
                            fontSize: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              firebaseCompleteRef.exists
                  ? Container(
                      margin: const EdgeInsets.all(10),
                      height: screenHeight / 10,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              opacity: 0.3,
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/${widget.index}.png"))),
                      child: InkWell(
                        onTap: () {
                          value.questionCount = 0;
                          value.correctCount = 0;
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ExerciceScreen(index: widget.index);
                            },
                          ));
                        },
                        child: Center(
                          child: Text("Challenge 2 - Pratical Exercices",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.vt323(
                                  fontSize: screenWidth / 10,
                                  color: const Color.fromARGB(255, 0, 255, 8))),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ));
        }));
  }
}
