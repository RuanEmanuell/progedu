import 'package:alarme/models/questions1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:provider/provider.dart';


import '../../controller/controller.dart';
import '../../widgets/login/maintext.dart';
import '../../widgets/login/input.dart';
import '../../widgets/login/mainbutton.dart';

import '../home.dart';

class NameScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    nameAction() async {
      try {
        for (var index = 0; index < quizes.length; index++) {
          FirebaseFirestore.instance
              .collection(user!.uid)
              .doc(index.toString())
              .set({quizes[index]: "0"});
        }
        await user!.updateDisplayName(nameController.text.trim()).then(((value) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ));
        }));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content:
                Text(e.message == "Given String is empty or null" ? "Type your nickname" : e.message!)));
      }
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return OrientationBuilder(builder: (context, orientation) {
            return Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                MainText(text: "What's your nickname?"),
                SizedBox(height: screenHeight / 60),
                InputWidget(controller: nameController, value: value, hintText: "Type your nickname..."),
                MainButton(
                    onPressed: () {
                      nameAction();
                    },
                    orientation: orientation,
                    text: "Choose nickname")
              ]),
            );
          });
        }));
  }
}
