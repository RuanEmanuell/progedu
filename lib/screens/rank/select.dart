import 'package:alarme/models/questions1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/general/appbar.dart';
import '../../widgets/general/languagebutton.dart';
import '../../widgets/general/text.dart';
import 'rank.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar:
            PreferredSize(preferredSize: Size.fromHeight(screenHeight / 15), child: const MainAppBar()),
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SELECT A RANKING",
                textAlign: TextAlign.center,
                style: GoogleFonts.vt323(
                    fontSize: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
            SizedBox(height: screenHeight / 30),
            ListView.builder(
                shrinkWrap: true,
                itemCount: quizes.length,
                itemBuilder: (context, index) {
                  return LanguageButton(
                      image: index,
                      text: quizes[index].toUpperCase(),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return RankScreen(index: index);
                          },
                        ));
                      },
                      child: Center(
                          child: CustomText(
                              text: quizes[index].toUpperCase(), fontSize: screenWidth / 10)));
                })
          ],
        ));
  }
}
