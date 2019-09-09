import 'dart:io';

class GetResponse {
  final String photo;
  final String recipeId;

  GetResponse(this.photo, this.recipeId);

  GetResponse.fromJson(Map<String, dynamic> json)
      : photo = json['photo'],
        recipeId = json['recipeId'];

  Map<String, dynamic> toJson() =>
      {
        'photo': photo,
        'recipeId': recipeId,
      };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["photo"] = photo;
    map["recipeId"] = recipeId;


    return map;
  }
}
