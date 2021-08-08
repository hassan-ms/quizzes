import 'package:flutter/cupertino.dart';

class AnswerManager with ChangeNotifier {
  int _choosen = -1;
  int get choosen {
    return _choosen;
  }

  void changeChoosen(ch) {
    _choosen = ch;
    notifyListeners();
  }
}
