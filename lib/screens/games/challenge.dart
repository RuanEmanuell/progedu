import 'package:alarme/screens/games/exercices.dart';
import 'package:alarme/screens/games/quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../models/questions1.dart';
import '../../models/strings.dart';
import '../../widgets/general/appbar.dart';
import '../../widgets/general/languagebutton.dart';
import '../../widgets/general/loading.dart';
import '../../widgets/general/text.dart';

class ChallengeScreen extends StatefulWidget {
  final dynamic index;

  const ChallengeScreen({super.key, required this.index});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  var user = FirebaseAuth.instance.currentUser;

  dynamic firebaseCompleteRef;
  dynamic firebaseCompleteRef2;

  checkExists() async {
    Provider.of<Controller>(context, listen: false).loading = true;
    firebaseCompleteRef =
        await FirebaseFirestore.instance.collection(user!.uid).doc("complete${widget.index}").get();
    firebaseCompleteRef2 =
        await FirebaseFirestore.instance.collection(user!.uid).doc("complete${widget.index} 2").get();

    Future.delayed(const Duration(seconds: 2), () {
      if (firebaseCompleteRef != null) {
        Provider.of<Controller>(context, listen: false).stopLoading();
      }
    });
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight / 15), child: const SecondaryAppBar()),
        body: Consumer<Controller>(builder: (context, value, child) {
          return value.loading
              ? const LoadingWidget()
              : SingleChildScrollView(
                  child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        child: CustomText(
                            text: quizes[widget.index].toUpperCase(), fontSize: screenWidth / 7.5)),
                    LanguageButton(
                        image: widget.index,
                        text: strings[value.language]["c1"],
                        onTap: () {
                          value.questionCount = 0;
                          value.correctCount = 0;
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return QuizScreen(index: widget.index);
                            },
                          ));
                        }),
                    const SizedBox(height: 10),
                    firebaseCompleteRef.exists
                        ? LanguageButton(
                            image: widget.index,
                            text: strings[value.language]["c2"],
                            onTap: () {
                              value.questionCount = 0;
                              value.correctCount = 0;
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ExerciceScreen(index: widget.index);
                                },
                              ));
                            })
                        : Container(),
                    firebaseCompleteRef2.exists
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: LanguageButton(
                                image: widget.index, text: strings[value.language]["c3"], onTap: () {}),
                          )
                        : Container()
                  ],
                ));
        }));
  }
}
