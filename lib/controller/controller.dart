import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  var controller;

  var selectedPageIndex = 0;

  bool loading = false;

  void startLoading() {
    loading = true;
    notifyListeners();
  }

  void stopLoading() {
    loading = false;
    notifyListeners();
  }

  void changeBottomNavigation() {
    selectedPageIndex = selectedPageIndex;
    notifyListeners();
  }

  var inputColor = const Color.fromARGB(255, 253, 228, 0);

  var questionCount = 0;
  var correctCount = 0;

  bool correctTextController = false;
  bool correct = false;

  bool tappable = true;

  var awnserText = "Your code will be here...";

  var correctColorController = Colors.red;

  changeAnwser() {
    awnserText = controller.text;
    notifyListeners();
  }

  void passQuestion() {
    Future.delayed(const Duration(seconds: 3), () {
      correct = false;
      questionCount++;
      tappable = true;
      correctColorController = Colors.red;
      correctTextController = false;
      awnserText = "Your code will be here...";
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
    correctTextController = true;
    correctColorController = Colors.green;
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
