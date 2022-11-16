import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

import "login.dart";
import "home.dart";
import "../widgets/input.dart";

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return OrientationBuilder(builder: (context, orientation) {
            return SingleChildScrollView(
                child: Column(children: [
              SafeArea(
                child: Container(
                    margin: EdgeInsets.only(top: screenHeight / 60, bottom: screenHeight / 60),
                    height:
                        orientation == Orientation.portrait ? screenHeight / 3.5 : screenHeight / 2.25,
                    child: Image.asset("assets/images/logo.png")),
              ),
              Text("/ProgEdu",
                  style: GoogleFonts.vt323(
                      fontSize: screenWidth / 7, color: const Color.fromARGB(255, 0, 255, 8))),
              Text("Learn to code now!",
                  style: GoogleFonts.vt323(
                      fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
              SizedBox(height: screenHeight / 60),
              InputWidget(controller: emailController, hintText: "Type an email...", value: value),
              InputWidget(controller: passwordController, hintText: "Type a password...", value: value),
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight / 40, right: screenWidth / 15, left: screenWidth / 15),
                width: screenWidth,
                height: orientation == Orientation.portrait ? screenHeight / 10 : screenHeight / 5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 206, 7)),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text, password: passwordController.text)
                          .then(((value) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                      }));
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.message == "Given String is empty or null"
                              ? "One or more fields are empty"
                              : e.message!)));
                    }
                  },
                  child: Text("Register", style: GoogleFonts.vt323(fontSize: screenWidth / 14)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight / 40, bottom: screenHeight / 40),
                child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ));
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Already has an account?",
                          style: GoogleFonts.vt323(
                              fontSize: screenWidth / 20, color: const Color.fromARGB(255, 0, 255, 8))),
                      TextSpan(
                          text: " Login",
                          style: GoogleFonts.vt323(fontSize: screenWidth / 20, color: Colors.yellow)),
                    ]))),
              )
            ]));
          });
        }));
  }
}
