import 'package:flutter/material.dart';

class ItemDetailsFeed with ChangeNotifier {
  String name;
  String photo;
  String preparationTime;
  String serves;
  String complexity;
  bool like;

  ItemDetailsFeed(this.name, this.photo, this.preparationTime, this.serves,
      this.complexity, this.like) {
    if (name == null) {
      name = "default";
    }
    if (photo == null) {
      photo =
          "https://livingstonbagel.com/wp-content/uploads/2016/11/food-placeholder.jpg";
    }
    if (preparationTime == null) {
      preparationTime = "5";
    }
    if (serves == null) {
      serves = "1";
    }
    if (complexity == null) {
      complexity = "Easy";
    }
  }

  void likeUpdate(value) {
    like = value;
    notifyListeners();
  }

  String getName() {
    return name;
  }
}
