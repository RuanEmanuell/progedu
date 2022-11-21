import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  var controller;
  var value;
  var hintText;

  InputWidget({required this.controller, required this.value, required this.hintText});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
          top: screenHeight / 80,
          right: screenWidth / 15,
          left: screenWidth / 15,
          bottom: screenHeight / 80),
      child: TextFormField(
          controller: controller,
          onChanged:(newValue){
            value.changeAnwser();
          },
          onTap: () {
            value.inputTap();
          },
          onFieldSubmitted: (newValue) {
            value.inputActive();
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.vt323(
                fontSize: screenWidth / 14, color: const Color.fromARGB(255, 0, 255, 8)),
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2.5)),
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 2.5)),
          ),
          style: GoogleFonts.vt323(fontSize: screenWidth / 14, color: value.inputColor)),
    );
  }
}
