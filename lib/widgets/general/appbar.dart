import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../screens/login/register.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("/ProgEdu",
            style: GoogleFonts.vt323(
                fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
        leading: IconButton(
            onPressed: () async {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      backgroundColor: Color.fromARGB(255, 99, 98, 98),
                      title: const Text("Are you sure you want to exit?"),
                      content: const Text("You will logout and return to main screen."),
                      actions: [
                        Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                Provider.of<Controller>(context, listen: false).startLoading();
                                await FirebaseAuth.instance.signOut().then(
                                  (value) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return RegisterScreen();
                                      },
                                    ));
                                    Provider.of<Controller>(context, listen: false).stopLoading();
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: Text("Exit",
                                  style: GoogleFonts.vt323(
                                      fontSize: screenWidth / 15, color: Colors.white))),
                        )
                      ]);
                },
              );
            },
            icon: Icon(Icons.arrow_back,
                size: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))));
  }
}

class SecondaryAppBar extends StatelessWidget {
  const SecondaryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("/ProgEdu",
            style: GoogleFonts.vt323(
                fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close,
                  size: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
        ]);
  }
}
