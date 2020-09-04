import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String kboyText = 'test';

  void changeKboyText() {
    kboyText = 'testApp';
    notifyListeners();
  }
}
