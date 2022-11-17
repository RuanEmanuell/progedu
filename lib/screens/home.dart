import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

import "../screens/loginscreens/register.dart";

class HomeScreen extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 27, 27, 27),
          elevation: 0,
          centerTitle: true,
          title: Text("/ProgEdu",
              style: GoogleFonts.vt323(
                  fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
          leading: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreen();
                    },
                  ));
                });
              },
              icon: Icon(Icons.arrow_back,
                  size: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
        ),
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
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 56, 56, 56), borderRadius: BorderRadius.circular(10)),
                  height: screenHeight / 1.44,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print(index);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(15),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(screenWidth / 50),
                                child: Image.asset("assets/images/$index.png"))),
                      );
                    },
                  ),
                )
              ]),
            ));
          });
        }));
  }
}
