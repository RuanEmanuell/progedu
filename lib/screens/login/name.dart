import '../../models/questions1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../main.dart';
import '../../models/strings.dart';
import '../../widgets/general/loading.dart';
import '../../widgets/login/maintext.dart';
import '../../widgets/general/input.dart';
import '../../widgets/login/mainbutton.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    nameAction() async {
      try {
        Provider.of<Controller>(context, listen: false).startLoading();
        for (var index = 0; index < quizes.length; index++) {
          FirebaseFirestore.instance
              .collection(user!.uid)
              .doc(index.toString())
              .set({quizes[index]: "0"});
        }
        await user!.updateDisplayName(nameController.text.trim()).then(((value) {
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
                ? strings[Provider.of<Controller>(context, listen: false).language]["emptyname"]
                : e.message!)));
        Provider.of<Controller>(context, listen: false).stopLoading();
      }
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return value.loading
              ? const LoadingWidget()
              : Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    MainText(text: strings[value.language]["name"]),
                    SizedBox(height: screenHeight / 60),
                    NameInputWidget(
                        controller: nameController,
                        value: value,
                        hintText: strings[value.language]["emptyname"]),
                    MainButton(
                        onPressed: () {
                          nameAction();
                        },
                        text: strings[value.language]["choosename"])
                  ]),
                );
        }));
  }
}
