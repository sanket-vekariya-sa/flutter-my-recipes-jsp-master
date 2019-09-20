import 'package:flutter/material.dart';

class ItemDetailsFeed with ChangeNotifier {
  int recipeId;
  String name;
  String photo;
  String preparationTime;
  String serves;
  String complexity;
  bool like;
  String youtubeUrl;

  ItemDetailsFeed(this.recipeId, this.name, this.photo, this.preparationTime,
      this.serves, this.complexity, this.like, this.youtubeUrl) {
    if (name == null) {
      name = "default";
    }
    if (photo == null) {
      photo = "https://media.giphy.com/media/g8rEwOqIStrBC/giphy.gif";
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
    if (youtubeUrl == null) {
      youtubeUrl = "";
    }
    if (recipeId == null) {
      recipeId = 1;
    }
  }

  bool getLike() => like;


  ItemDetailsFeed.fromFeed(bool like){
    this.like = like;
  }
  void likeUpdate(value) {
    like = value;
    notifyListeners();
  }

  String getName() {
    return name;
  }
}
