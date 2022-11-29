import 'package:alarme/screens/games/challenge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../models/questions1.dart';
import '../../models/strings.dart';
import '../../widgets/general/appbar.dart';
import '../../widgets/general/loading.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final dynamic user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar:
            PreferredSize(preferredSize: Size.fromHeight(screenHeight / 15), child: const MainAppBar()),
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return SingleChildScrollView(
              child: Center(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(
                    left: screenWidth / 20,
                    right: screenWidth / 20,
                    top: screenHeight / 30,
                    bottom: screenHeight / 60),
                child: Text("${strings[value.language]["hello"]}, ${user!.displayName.toString()}!",
                    style: GoogleFonts.vt323(
                        fontSize: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: screenWidth / 20, right: screenWidth / 20, bottom: screenHeight / 30),
                child: Text(strings[value.language]["challenge"],
                    style: GoogleFonts.vt323(
                        fontSize: screenWidth / 14, color: const Color.fromARGB(255, 0, 255, 8))),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: screenHeight / 1.44,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: quizes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          value.questionCount = 0;
                          value.correctCount = 0;
                          value.correct = false;
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChallengeScreen(index: index);
                            },
                          ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 35,
                            right: 35,
                          ),
                          child: Wrap(children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Center(
                                child: Text(quizes[index].toUpperCase(),
                                    style: GoogleFonts.vt323(
                                        fontSize: screenWidth / 15,
                                        color: const Color.fromARGB(255, 0, 255, 8))),
                              ),
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(screenWidth / 50),
                                child: Image.asset("assets/images/$index.png")),
                            StreamBuilder<QuerySnapshot>(
                                stream: collectionStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(strings[value.language]["error"]);
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const LoadingWidget();
                                  }

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          color: const Color.fromARGB(255, 0, 255, 8),
                                          width: screenWidth *
                                              int.parse(snapshot.data!.docs[index][quizes[index]]) /
                                              300,
                                          height: screenHeight / 100),
                                      Center(
                                        child: Text(
                                            "${snapshot.data!.docs[index][quizes[index]]}% ${strings[value.language]["concluded"]}",
                                            style: GoogleFonts.vt323(
                                                fontSize: screenWidth / 20,
                                                color: const Color.fromARGB(255, 0, 255, 8))),
                                      ),
                                    ],
                                  );
                                }),
                          ]),
                        ));
                  },
                ),
              )
            ]),
          ));
        }));
  }
}
