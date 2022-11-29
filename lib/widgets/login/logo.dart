import "package:flutter/material.dart";

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: screenHeight / 30, bottom: screenHeight / 60),
          height: screenHeight / 3.5,
          child: Image.asset("assets/images/logo.png")),
    );
  }
}
