import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: screenHeight,
                width: screenWidth,
                color: const Color.fromARGB(255, 56, 56, 56),
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(top: screenHeight / 15, bottom: screenHeight / 60),
                      height: screenHeight / 3,
                      child: Image.asset("assets/images/logo.png")),
                  Text("/ProgEdu",
                      style: GoogleFonts.vt323(
                          fontSize: screenWidth / 7, color: const Color.fromARGB(255, 0, 255, 8))),
                  Text("Learn to code now!",
                      style: GoogleFonts.vt323(
                          fontSize: screenWidth / 14, color: const Color.fromARGB(255, 0, 255, 8))),
                  Container(
                    margin: EdgeInsets.only(
                        top: screenHeight / 30, right: screenWidth / 15, left: screenWidth / 15),
                    child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Type an email...",
                          hintStyle: GoogleFonts.vt323(
                              fontSize: screenWidth / 14, color: const Color.fromARGB(255, 0, 255, 8)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green, width: 2.5)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow, width: 2.5)),
                        ),
                        style: GoogleFonts.vt323(fontSize: screenWidth / 14, color: Colors.yellow)),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: screenHeight / 40,
                        right: screenWidth / 15,
                        left: screenWidth / 15,
                        bottom: screenHeight / 40),
                    child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Type an password...",
                          hintStyle: GoogleFonts.vt323(
                              fontSize: screenWidth / 14, color: const Color.fromARGB(255, 0, 255, 8)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green, width: 2.5)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow, width: 2.5)),
                        ),
                        style: GoogleFonts.vt323(fontSize: screenWidth / 14, color: Colors.yellow)),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: screenWidth / 15, left: screenWidth / 15),
                    width: screenWidth,
                    height: screenHeight / 10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 206, 7)),
                      onPressed: () {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text, password: passwordController.text);
                      },
                      child: Text("Register", style: GoogleFonts.vt323(fontSize: screenWidth / 14)),
                    ),
                  )
                ]))));
  }
}
