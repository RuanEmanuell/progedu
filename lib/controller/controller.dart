import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {

  var controller;

  var inputColor = const Color.fromARGB(255, 253, 228, 0);

  var questionCount = 0;
  var correctCount = 0;

  bool correct = false;

  bool tappable = true;

  var awnserText="Your code will be here...";

  changeAnwser(){
    awnserText=controller.text;
    notifyListeners();
  }

  void passQuestion() {
    Future.delayed(const Duration(seconds: 3), () {
      correct = false;
      questionCount++;
      tappable = true;
      notifyListeners();
    });
  }

  void showCorrect() {
    correct = true;
    tappable = false;
    notifyListeners();
  }

  void correctQuestion() {
    correctCount++;
    correct = true;
    notifyListeners();
  }

  void inputTap() {
    inputColor = const Color.fromARGB(255, 253, 228, 0);
    notifyListeners();
  }

  void inputActive() {
    inputColor = const Color.fromARGB(255, 0, 255, 8);
    notifyListeners();
  }
}
