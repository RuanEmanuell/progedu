import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final dynamic text;
  final dynamic fontSize;

  const CustomText({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.vt323(fontSize: fontSize, color: const Color.fromARGB(255, 0, 255, 8)));
  }
}
