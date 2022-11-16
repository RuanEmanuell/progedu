import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> collectionStream =
        FirebaseFirestore.instance.collection("rankings").snapshots();

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: collectionStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Text(data["rank"]);
          }).toList(),
        );
      },
    ));
  }
}
