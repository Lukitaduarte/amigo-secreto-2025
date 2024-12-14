import 'package:flutter/material.dart';

class Inventory extends ChangeNotifier {
  bool _ivermectina = false;
  bool _cloroquina = false;

  bool get ivermectina => _ivermectina;
  bool get cloroquina => _cloroquina;

  void catchIvermectina() {
    _ivermectina = true;
    print('Ivermectina catched!');
    notifyListeners();
  }

  void catchCloroquina() {
    _cloroquina = true;
    print('Cloroquina catched!');
    notifyListeners();
  }

  void reset() {
    _ivermectina = false;
    _cloroquina = false;
    notifyListeners();
  }
}
