import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../widgets/general/loading.dart';
import 'login.dart';
import 'name.dart';
import '../../widgets/login/maintext.dart';
import '../../widgets/login/mainbutton.dart';
import '../../widgets/login/logo.dart';
import '../../widgets/general/input.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    registerAction() async {
      try {
        Provider.of<Controller>(context, listen: false).startLoading();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(), password: passwordController.text.trim())
            .then(((value) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return NameScreen();
            },
          ));
          Provider.of<Controller>(context, listen: false).stopLoading();
        }));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(e.message == "Given String is empty or null"
                ? "One or more fields are empty"
                : e.message!)));
        Provider.of<Controller>(context, listen: false).stopLoading();
      }
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return value.loading
              ? const LoadingWidget()
              : OrientationBuilder(builder: (context, orientation) {
                  return SingleChildScrollView(
                      child: Column(children: [
                    LogoWidget(orientation: orientation),
                    MainText(text: "Learn to code now!"),
                    SizedBox(height: screenHeight / 60),
                    InputWidget(controller: emailController, hintText: "Type an email...", value: value),
                    InputWidget(
                        controller: passwordController, hintText: "Type a password...", value: value),
                    MainButton(
                        onPressed: () {
                          registerAction();
                        },
                        orientation: orientation,
                        text: "Register"),
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
                                    fontSize: screenWidth / 20,
                                    color: const Color.fromARGB(255, 0, 255, 8))),
                            TextSpan(
                                text: " Login",
                                style:
                                    GoogleFonts.vt323(fontSize: screenWidth / 20, color: Colors.yellow)),
                          ]))),
                    )
                  ]));
                });
        }));
  }
}
