import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  var count = 10;

  void increase() {
    count++;
    notifyListeners();
  }
}
