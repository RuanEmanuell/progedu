import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../models/strings.dart';

class MainText extends StatelessWidget {
  final String text;

  const MainText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(children: [
      Text(strings[Provider.of<Controller>(context, listen: false).language]["progedu"],
          textAlign: TextAlign.center,
          style:
              GoogleFonts.vt323(fontSize: screenWidth / 7, color: const Color.fromARGB(255, 0, 255, 8))),
      SizedBox(height: screenHeight / 100),
      Text(text,
          textAlign: TextAlign.center,
          style: GoogleFonts.vt323(
              fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
    ]);
  }
}
