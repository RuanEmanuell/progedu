import 'package:alarme/screens/games/challenge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../models/questions1.dart';

class HomeScreen extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return OrientationBuilder(builder: (context, orientation) {
            return SingleChildScrollView(
                child: Center(
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(
                      left: screenWidth / 20,
                      right: screenWidth / 20,
                      top: screenHeight / 30,
                      bottom: screenHeight / 60),
                  child: Text("Hello, ${user!.displayName.toString()}!",
                      style: GoogleFonts.vt323(
                          fontSize: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenWidth / 20, right: screenWidth / 20, bottom: screenHeight / 30),
                  child: Text("What challenge you wanna play?",
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
                                          fontSize: screenWidth / 14,
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
                                      return const Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
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
                                              "${snapshot.data!.docs[index][quizes[index]]}% concluded",
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
          });
        }));
  }
}
