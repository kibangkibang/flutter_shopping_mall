import 'package:flutter/material.dart';

class SearchQuery extends ChangeNotifier {
  String text = '';

  void updateText(String newText) {
    text = newText;
    print(text);
    notifyListeners();
  }
}
