import 'package:flutter/material.dart';

class InstructionDetailsFeed with ChangeNotifier {
  int id;
  String instruction;

  InstructionDetailsFeed(this.id, this.instruction) {
    if (id == null) {
      id = 0;
    }
    if (instruction == null) {
      instruction = "default instruction";
    }
  }
}
