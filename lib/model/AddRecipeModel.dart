import 'dart:io';

import 'package:flutter/material.dart';

class AddRecipeModel with ChangeNotifier {
  int recipeId;
  String name;
  String preparationTime;
  String complexity;
  String serves;
  List ingredents;
  List steps;
  String youTubeUrl;
  String image;
  List metaTags;

  AddRecipeModel(this.recipeId, this.name, this.preparationTime,
      this.complexity, this.serves, this.ingredents, this.steps,
      this.youTubeUrl, this.image, this.metaTags) {
    if (recipeId == null) {
      recipeId = 1;
    }
    if (name == null) {
      name = "default";
    }
    if (preparationTime == null) {
      preparationTime = "5";
    }
    if (complexity == null) {
      complexity = "Easy";
    }
    if (serves == null) {
      serves = "1";
    }
    if (ingredents == null) {
      ingredents = List(2);
    }
    if (steps == null) {
      steps = List(2);
    }
    if (youTubeUrl == null) {
      youTubeUrl = "";
    }
    if (image == null) {
      image =
      "https://cdn.dribbble.com/users/645440/screenshots/3266490/loader-2_food.gif";
    }
    if (metaTags == null) {
      name = "default";
    }
  }
}