import "package:flutter/material.dart";

class LogoWidget extends StatelessWidget {
  var orientation;

  LogoWidget({required this.orientation});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: screenHeight / 60, bottom: screenHeight / 60),
          height: orientation == Orientation.portrait ? screenHeight / 3.5 : screenHeight / 2.25,
          child: Image.asset("assets/images/logo.png")),
    );
  }
}
