import 'package:flutter/material.dart';

class ItemDetailsFeed with ChangeNotifier{
  final String name;
  String photo;
  final String preparationTime;
  final String serves;
  final String complexity;
   bool like;


  ItemDetailsFeed(this.name, this.photo,this.preparationTime,this.serves,this.complexity,this.like) {
    if (name == null) {
      throw new ArgumentError("name of ItemDetailsFeed cannot be null. "
          "Received: '$name'");
    }
    if (photo == null) {
//      throw new ArgumentError("photo of ItemDetailsFeed cannot be null. "
//          "Received: '$photo'");
      photo = "https://livingstonbagel.com/wp-content/uploads/2016/11/food-placeholder.jpg";
    }
    if (preparationTime == null) {
      throw new ArgumentError("preparationTime of ItemDetailsFeed cannot be null. "
          "Received: '$preparationTime'");
    }
    if (serves == null) {
      throw new ArgumentError("serves of ItemDetailsFeed cannot be null. "
          "Received: '$serves'");
    }
    if (complexity == null) {
      throw new ArgumentError("complexity of ItemDetailsFeed cannot be null. "
          "Received: '$complexity'");
    }
  }

  void likeUpdate(value){
    like = value;
    notifyListeners();
  }

  String getName(){
    return name;
}
}
