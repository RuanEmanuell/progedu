import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  var inputColor = const Color.fromARGB(255, 253, 228, 0);

  var questionCount = 0;
  var correctCount = 0;

  bool correct = false;

  void passQuestion() {
    Future.delayed(const Duration(seconds: 3), () {
      correct = false;
      questionCount++;
      notifyListeners();
    });
  }

  void showCorrect() {
    correct = true;
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
