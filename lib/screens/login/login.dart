import '../../controller/controller.dart';
import '../../widgets/login/mainbutton.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/strings.dart';
import '../../widgets/general/loading.dart';
import '../../widgets/login/maintext.dart';
import '../../widgets/login/logo.dart';
import '../../widgets/general/input.dart';

import 'forgot.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    loginAction() async {
      try {
        Provider.of<Controller>(context, listen: false).startLoading();
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(), password: passwordController.text.trim())
            .then(((value) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const MyApp();
            },
          ));
          Provider.of<Controller>(context, listen: false).stopLoading();
        }));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(e.message == "Given String is empty or null"
                ? strings[Provider.of<Controller>(context, listen: false).language]["emptyboth"]
                : e.message!)));
        Provider.of<Controller>(context, listen: false).stopLoading();
      }
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return value.loading
              ? const LoadingWidget()
              : SingleChildScrollView(
                  child: Stack(children: [
                  Column(children: [
                    LogoWidget(),
                    MainText(text: strings[value.language]["welcome"]),
                    SizedBox(height: screenHeight / 60),
                    InputWidget(
                        controller: emailController,
                        hintText: strings[value.language]["email"],
                        value: value),
                    InputWidget(
                        controller: passwordController,
                        hintText: strings[value.language]["password"],
                        value: value),
                    Container(
                      margin: EdgeInsets.only(right: screenWidth / 15),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ForgotScreen();
                            }));
                          },
                          child: Text(strings[value.language]["forgotpassword"],
                              style:
                                  GoogleFonts.vt323(fontSize: screenWidth / 20, color: Colors.yellow))),
                    ),
                    MainButton(
                        onPressed: () {
                          loginAction();
                        },
                        text: strings[value.language]["login"]),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight / 40, bottom: screenHeight / 40),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: strings[value.language]["noaccount"],
                                style: GoogleFonts.vt323(
                                    fontSize: screenWidth / 20,
                                    color: const Color.fromARGB(255, 0, 255, 8))),
                            TextSpan(
                                text: strings[value.language]["sign"],
                                style:
                                    GoogleFonts.vt323(fontSize: screenWidth / 20, color: Colors.yellow)),
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
        }));
  }
}
