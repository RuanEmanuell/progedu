import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../main.dart';

class RankScreen extends StatelessWidget {
  var index;

  RankScreen({this.index});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Stream<QuerySnapshot> quizStream =
        FirebaseFirestore.instance.collection("${index}quizrankings").snapshots();
    Stream<QuerySnapshot> exercicesStream =
        FirebaseFirestore.instance.collection("${index}exercicesrankings").snapshots();

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
                    Provider.of<Controller>(context, listen: false).selectedPageIndex = 0;
                    Provider.of<Controller>(context, listen: false).changeBottomNavigation();
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return MyApp();
                    }));
                  },
                  icon: Icon(Icons.close,
                      size: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
            ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Quiz Rankings",
                style: GoogleFonts.vt323(
                    fontSize: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
            StreamBuilder<QuerySnapshot>(
              stream: quizStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return SizedBox(
                  height: screenHeight / 3,
                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data["name"],
                              style: GoogleFonts.vt323(
                                  fontSize: screenWidth / 10,
                                  color: const Color.fromARGB(255, 0, 255, 8))),
                          SizedBox(width: screenWidth / 20),
                          Text(data["rank"],
                              style: GoogleFonts.vt323(
                                  fontSize: screenWidth / 10,
                                  color: const Color.fromARGB(255, 0, 255, 8))),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                width: screenWidth,
                height: screenHeight / 100,
                color: Colors.grey),
            Text("Exercice Rankings",
                style: GoogleFonts.vt323(
                    fontSize: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
            StreamBuilder<QuerySnapshot>(
              stream: exercicesStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return SizedBox(
                  height: screenHeight / 2.75,
                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data["name"],
                              style: GoogleFonts.vt323(
                                  fontSize: screenWidth / 10,
                                  color: const Color.fromARGB(255, 0, 255, 8))),
                          SizedBox(width: screenWidth / 20),
                          Text(data["rank"],
                              style: GoogleFonts.vt323(
                                  fontSize: screenWidth / 10,
                                  color: const Color.fromARGB(255, 0, 255, 8))),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
