import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../widgets/login/maintext.dart';
import '../../widgets/login/input.dart';
import '../../widgets/login/mainbutton.dart';

class ForgotScreen extends StatelessWidget {
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    resetPasswordAction() async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim())
            .then(((value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.blue,
              content: Text("Email sent, remember to check your spam box")));
        }));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content:
                Text(e.message == "Given String is empty or null" ? "Type your email" : e.message!)));
      }
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return OrientationBuilder(builder: (context, orientation) {
            return Stack(children: [
              Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  MainText(text: "Send email to reset password"),
                  SizedBox(height: screenHeight / 60),
                  InputWidget(controller: emailController, value: value, hintText: "Type your email..."),
                  MainButton(
                      onPressed: () {
                        resetPasswordAction();
                      },
                      orientation: orientation,
                      text: "Reset password")
                ]),
              ),
              SafeArea(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,
                        size: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
              )
            ]);
          });
        }));
  }
}
