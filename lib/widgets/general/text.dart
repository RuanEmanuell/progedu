import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  dynamic text;
  dynamic fontSize;

  CustomText({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.vt323(fontSize: fontSize, color: const Color.fromARGB(255, 0, 255, 8)));
  }
}
