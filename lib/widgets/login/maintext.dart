import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class MainText extends StatelessWidget {
  var text;

  MainText({required this.text});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(children: [
      Text("/ProgEdu",
          style:
              GoogleFonts.vt323(fontSize: screenWidth / 7, color: const Color.fromARGB(255, 0, 255, 8))),
      Text(text,
          style: GoogleFonts.vt323(
              fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
    ]);
  }
}
