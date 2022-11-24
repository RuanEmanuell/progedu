import 'package:alarme/controller/controller.dart';
import 'package:alarme/widgets/login/mainbutton.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/login/maintext.dart';
import '../../widgets/login/logo.dart';
import '../../widgets/general/input.dart';

import 'forgot.dart';
import '../games/home.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    loginAction() async {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(), password: passwordController.text.trim())
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
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return OrientationBuilder(builder: (context, orientation) {
            return SingleChildScrollView(
                child: Stack(children: [
              Column(children: [
                LogoWidget(orientation: orientation),
                MainText(text: "Welcome back!"),
                SizedBox(height: screenHeight / 60),
                InputWidget(controller: emailController, hintText: "Type your email...", value: value),
                InputWidget(
                    controller: passwordController, hintText: "Type your password...", value: value),
                Container(
                  margin: EdgeInsets.only(right: screenWidth / 15),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ForgotScreen();
                        }));
                      },
                      child: Text("Forgot your password?",
                          style: GoogleFonts.vt323(fontSize: screenWidth / 20, color: Colors.yellow))),
                ),
                MainButton(
                    onPressed: () {
                      loginAction();
                    },
                    orientation: orientation,
                    text: "Login"),
                Container(
                  margin: EdgeInsets.only(top: screenHeight / 40, bottom: screenHeight / 40),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account yet?",
                            style: GoogleFonts.vt323(
                                fontSize: screenWidth / 20,
                                color: const Color.fromARGB(255, 0, 255, 8))),
                        TextSpan(
                            text: " Sign in",
                            style: GoogleFonts.vt323(fontSize: screenWidth / 20, color: Colors.yellow)),
                      ]))),
                )
              ]),
              SafeArea(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,
                        size: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
              )
            ]));
          });
        }));
  }
}
