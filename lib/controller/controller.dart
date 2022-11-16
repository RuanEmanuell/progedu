import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  var inputColor = const Color.fromARGB(255, 253, 228, 0);

  void inputTap() {
    inputColor = const Color.fromARGB(255, 253, 228, 0);
    notifyListeners();
  }

  void inputActive() {
    inputColor = const Color.fromARGB(255, 0, 255, 8);
    notifyListeners();
  }
}
