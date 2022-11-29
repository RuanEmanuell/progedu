import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../models/strings.dart';
import '../general/text.dart';

class RankList extends StatelessWidget {
  final dynamic stream;

  RankList({super.key, required this.stream});

  final dynamic user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(strings[Provider.of<Controller>(context, listen: false).language]["error"]);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return SizedBox(
          height: screenHeight / 3,
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Container(
                margin: EdgeInsets.all(screenWidth / 20),
                decoration: BoxDecoration(
                    color: data["name"] == user.displayName ? Colors.grey : Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: data["name"], fontSize: screenWidth / 10),
                    SizedBox(width: screenWidth / 20),
                    CustomText(text: data["rank"], fontSize: screenWidth / 10),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
