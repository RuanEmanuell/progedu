import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

class MainButton extends StatelessWidget {
  var onPressed;
  var orientation;
  var text;

  MainButton({required this.onPressed, this.orientation, required this.text});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 40, right: screenWidth / 15, left: screenWidth / 15),
      width: screenWidth,
      height: orientation == Orientation.portrait ? screenHeight / 10 : screenHeight / 5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 206, 7)),
        onPressed: onPressed,
        child: Text(text, style: GoogleFonts.vt323(fontSize: screenWidth / 14)),
      ),
    );
  }
}
