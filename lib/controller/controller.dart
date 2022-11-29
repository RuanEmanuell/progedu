import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  String language = "english";

  //Text input color variable
  Color inputColor = const Color.fromARGB(255, 253, 228, 0);

  //Loading and navigation variables
  bool loading = false;
  int selectedPageIndex = 0;

  //Games variables
  int questionCount = 0;
  int correctCount = 0;
  bool correctTextController = false;
  bool correct = false;
  bool tappable = true;
  dynamic controller;
  String awnserText = "";
  Color correctColorController = Colors.red;

  //Change input color
  void inputTap() {
    inputColor = const Color.fromARGB(255, 253, 228, 0);
    notifyListeners();
  }

  void inputActive() {
    inputColor = const Color.fromARGB(255, 0, 255, 8);
    notifyListeners();
  }

  //Loading functions
  void startLoading() {
    loading = true;
    notifyListeners();
  }

  void stopLoading() {
    loading = false;
    notifyListeners();
  }

  //Bottom Navigation bar controller
  void changeBottomNavigation() {
    selectedPageIndex = selectedPageIndex;
    notifyListeners();
  }

  //Quiz questions controllers
  void passQuestion() {
    Future.delayed(const Duration(seconds: 3), () {
      correct = false;
      questionCount++;
      tappable = true;
      correctColorController = Colors.red;
      correctTextController = false;
      awnserText = "";
      controller.text = "";
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

  //Pratical exercice anwser controller
  void changeAnwser() {
    awnserText = controller.text;
    notifyListeners();
  }
}
