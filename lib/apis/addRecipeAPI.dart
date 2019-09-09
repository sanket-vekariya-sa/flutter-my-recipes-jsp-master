import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:Flavr/ui/Profile.dart';
import 'package:Flavr/ui/homeScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Flavr/model/loginModel.dart';
import 'package:http/http.dart' as http;

import 'getresponse.dart';

Future<GetResponse> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return GetResponse.fromJson(json.decode(response.body));
  });
}

Future<LoginModel> addRecipeAPI(BuildContext context, String name, String time,String complexcity,String serves,List ingredents ,List steps,String youTubeUrl,File image) async {
  LoginModel loginModel;
  final url = "http://35.160.197.175:3006/api/v1/recipe/add";
  final photoUrl = "http://35.160.197.175:3006/api/v1/recipe/add-update-recipe-photo";
  final ingredentsUrl = "http://35.160.197.175:3006/api/v1/recipe/add-ingredient";
  final stepsUrl = "http://35.160.197.175:3006/api/v1/recipe/add-instruction";

  var photoId;
  Dio dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
  };
  final response = await dio.post(
      url,
      data: {"name": name,"preparationTime": time,"serves":serves,"complexity":complexcity,"ytUrl":youTubeUrl}, options: Options(headers: map)).catchError(
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
//    if (response.statusCode == 200) {
//      Navigator.of(context).pushReplacementNamed('/HomeScreen');
//    }
    final responseindegrents = await dio.post(
        ingredentsUrl,
        data: {"ingredient":ingredents.toString(),"recipeId": photoId.toString().trim()}, options: Options(headers: map)).catchError(
            (dynamicError){
          print("called error loop indegrents");
        }

    );

    print("called if indegrents aadeed ===== $responseindegrents");
    final responsesteps = await dio.post(
        stepsUrl,
        data: {"instruction":steps.toString(),"recipeId": photoId.toString().trim()}, options: Options(headers: map)).catchError(
            (dynamicError){
          print("called error loop indegrents");
        }

    );
    print("called if indegrents aadeed ===== $responsesteps");

    if (responsesteps.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    }
//    GetResponse newPost = new GetResponse(image.toString(),photoId);
//    GetResponse p = await createPost(photoUrl,
//        body: newPost.toMap());
//    print("data :  $p");


  }


  return loginModel;
}

