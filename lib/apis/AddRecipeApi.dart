import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Flavr/model/AddRecipeModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Flavr/model/LoginModel.dart';
import 'package:http/http.dart' as http;
import 'GetResponseApi.dart';

Future<GetResponseApi> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return GetResponseApi.fromJson(json.decode(response.body));
  });
}

Future<AddRecipeModel> AddRecipeApi(BuildContext context, String name, String time,String complexcity,String serves,List ingredents ,List steps,String youTubeUrl,File image, List metaTags) async {

  print(complexcity);

  AddRecipeModel addrecipeModel;
  final url = "http://35.160.197.175:3006/api/v1/recipe/add";
  final photoUrl = "http://35.160.197.175:3006/api/v1/recipe/add-update-recipe-photo";
  final ingredentsUrl = "http://35.160.197.175:3006/api/v1/recipe/add-ingredient";
  final instructionUrl = "http://35.160.197.175:3006/api/v1/recipe/add-instruction";

  var photoId;
  Dio dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
  };
  final response = await dio.post(
      url,
      data: {"name": name,"preparationTime": time,"serves":serves,"complexity":complexcity,"ytUrl":youTubeUrl,"photo":image,"metaTags":metaTags}, options: Options(headers: map)).catchError(
          (dynamicError){
        print("called error loop");

      }

  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    print("called if loop");
    print("called if ===== $response");

    photoId = response.toString().substring(41,44);
    print("datais$photoId id");
    for(var i in ingredents) {

      final responseindegrents = await dio.post(
          ingredentsUrl,
          data: {
            "ingredient": i.toString(),
            "recipeId": photoId.toString().trim()
          }, options: Options(headers: map)).catchError(
              (dynamicError) {
            print("called error loop indegrents");
          }
      );
      print("called if indegrents aadeed ===== $responseindegrents");
    }

    for(var i in steps) {

      final responsesteps = await dio.post(
          instructionUrl,
          data: {"instruction": i.toString(), "recipeId": photoId.toString().trim()},
          options: Options(headers: map)).catchError(
              (dynamicError) {
            print("called error loop steps");
          }

      );

      final responsephoto = await dio.post(
          photoUrl,
          data: {
            "recipeId":photoId.toString().trim(),
            "photo": image
          }, options: Options(headers: map)).catchError(
              (dynamicError) {
            print("called error loop indegrents");
          }
      );
      print("called if indegrents aadeed ===== $responsesteps");
      if (responsesteps.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed('/DashBoardScreen');
      }
    }

  }


  return addrecipeModel;
}
