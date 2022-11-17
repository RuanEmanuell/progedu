import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';

import 'loginscreens/register.dart';

class HomeScreen extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(user!.displayName.toString()),
        ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return RegisterScreen();
                  },
                ));
              });
            },
            child: const Text("Exit"))
      ],
    ));
  }
}
