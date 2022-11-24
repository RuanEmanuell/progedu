import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

import '../general/text.dart';

class RankList extends StatelessWidget {
  dynamic stream;

  RankList({required this.stream});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return SizedBox(
          height: screenHeight / 3,
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: data["name"], fontSize: screenWidth / 10),
                  SizedBox(width: screenWidth / 20),
                  CustomText(text: data["rank"], fontSize: screenWidth / 10),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
