import 'package:flutter/material.dart';

class ItemDetailsFeed with ChangeNotifier {
  String name;
  String photo;
  String preparationTime;
  String serves;
  String complexity;
  bool like;
  String youtubeUrl;

  ItemDetailsFeed(this.name, this.photo, this.preparationTime, this.serves,
      this.complexity, this.like,this.youtubeUrl) {
    if (name == null) {
      name = "default";
    }
    if (photo == null) {
      photo =
          "https://zabas.com/wp-content/uploads/2014/09/Placeholder-food.jpg";
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
    if(youtubeUrl == null){
      youtubeUrl = "";
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
