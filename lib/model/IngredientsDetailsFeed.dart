import 'package:flutter/material.dart';

class IngredientsDetailsFeed with ChangeNotifier {
  int id;
  String ingredient;

  IngredientsDetailsFeed(this.id, this.ingredient) {
    if (id == null) {
      id = 0;
    }
    if (ingredient == null) {
      ingredient = "default ingredient";
    }
  }
}
