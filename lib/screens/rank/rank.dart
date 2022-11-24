import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/general/appbar.dart';
import '../../widgets/general/text.dart';
import '../../widgets/rank/ranklist.dart';

class RankScreen extends StatelessWidget {
  final dynamic index;

  const RankScreen({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Stream<QuerySnapshot> quizStream =
        FirebaseFirestore.instance.collection("${index}quizrankings").snapshots();
    Stream<QuerySnapshot> exerciceStream =
        FirebaseFirestore.instance.collection("${index}exercicesrankings").snapshots();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight / 15), child: CustomAppBar()),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: "Quiz Rankings", fontSize: screenWidth / 10),
            RankList(stream: quizStream),
            Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                width: screenWidth,
                height: screenHeight / 100,
                color: Colors.grey),
            CustomText(text: "Exerice Rankings", fontSize: screenWidth / 10),
            RankList(stream: exerciceStream),
          ],
        ));
  }
}
