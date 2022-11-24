import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

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
