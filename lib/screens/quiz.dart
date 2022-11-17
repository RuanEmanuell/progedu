import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../controller/controller.dart';


import "../models/questions.dart";

class QuizScreen extends StatelessWidget {
  var index;

  QuizScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Consumer<Controller>(builder: (context, value, child) {
          return Center(
            child: Container(child: Text(questions[quizes[index]][value.questionCount]["question"])),
          );
        }));
  }
}
