import 'dart:io';

import 'package:Flavr/values/CONSTANTS.dart';

class GetResponse {
  final String photo;
  final String recipeId;

  GetResponse(this.photo, this.recipeId);

  GetResponse.fromJson(Map<String, dynamic> json)
      : photo = json[CONSTANTS().PHOTO],
        recipeId = json[CONSTANTS().RECIPEID];

  Map<String, dynamic> toJson() =>
      {
        CONSTANTS().PHOTO: photo,
        CONSTANTS().RECIPEID: recipeId,
      };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map[CONSTANTS().PHOTO] = photo;
    map[CONSTANTS().RECIPEID] = recipeId;


    return map;
  }
}
