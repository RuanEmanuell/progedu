import 'package:alarme/models/questions1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'rank.dart';

class SelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SELECT A RANKING",
                textAlign: TextAlign.center,
                style: GoogleFonts.vt323(
                    fontSize: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
            SizedBox(height: screenHeight / 30),
            ListView.builder(
                shrinkWrap: true,
                itemCount: quizes.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.all(10),
                      height: screenHeight / 10,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              opacity: 0.3,
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/$index.png"))),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return RankScreen(index: index);
                            },
                          ));
                        },
                        child: Center(
                          child: Text(quizes[index].toUpperCase(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.vt323(
                                  fontSize: screenWidth / 10,
                                  color: const Color.fromARGB(255, 0, 255, 8))),
                        ),
                      ));
                })
          ],
        ));
  }
}
