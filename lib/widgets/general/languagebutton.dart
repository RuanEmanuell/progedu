import '../../widgets/general/text.dart';
import "package:flutter/material.dart";

class LanguageButton extends StatelessWidget {
  final dynamic image;
  final dynamic text;
  final dynamic onTap;
  final dynamic child;

  const LanguageButton(
      {super.key, required this.image, required this.text, required this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      height: screenHeight / 10,
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              opacity: 0.3, fit: BoxFit.cover, image: AssetImage("assets/images/$image.png"))),
      child: InkWell(
        onTap: onTap,
        child: Center(child: CustomText(text: text, fontSize: screenWidth / 10)),
      ),
    );
  }
}
