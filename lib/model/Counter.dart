import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  bool _counter;

  Counter(this._counter);

  bool getCounter() => _counter;
  bool setCounter(bool counter) => _counter = counter;

  void settCounter(){
    this._counter = true;
    notifyListeners();
  }

  void unsetCounter(){
    this._counter = false;
    notifyListeners();
  }
}