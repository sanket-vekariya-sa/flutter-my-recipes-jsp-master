import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Flavr/model/LoginModel.dart';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

Future<LoginModel> addRecipeAPI(
    BuildContext context,
    String name,
    String time,
    String complexcity,
    String serves,
    List ingredents,
    List steps,
    String youTubeUrl,
    File image,
    List metaTags) async {
  print(complexcity);

  LoginModel loginModel;
  final Constants = CONSTANTS();
  var photoId;
  Dio dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
    Constants.APITOKEN
  };
  final response = await dio
      .post(Constants.ADDNEWRECIPEAPI,
          data: {
            Constants.NAME: name,
            Constants.PREPARATIONTIME: time,
            Constants.SERVES: serves,
            Constants.COMPLEXITY: complexcity,
            Constants.YOUTUBEURL: youTubeUrl,
            Constants.METATAGS: metaTags
          },
          options: Options(headers: map))
      .catchError((dynamicError) {
  });

  print(response.statusCode);
  if (response.statusCode == 200) {
    var responsesteps;

    photoId = response.toString().substring(41,44);

    FormData formdata = new FormData();
    formdata.add(Constants.PHOTO, new UploadFileInfo(image, image.path, contentType: ContentType.parse('image/png')));
    formdata.add(Constants.RECIPEID, photoId);

    final responsePhoto = await dio
        .post(Constants.PHOTOURLAPI,data: formdata, options: Options(headers: map))
        .catchError((dynamicError) {
    });

    print("${responsePhoto.statusCode}");


    for (var i in ingredents) {
      final responseindegrents = await dio
          .post(Constants.ADDINGREDENTAPI,
              data: {
                Constants.INGREDENT: i.toString(),
                Constants.RECIPEID: photoId.toString().trim()
              },
              options: Options(headers: map))
          .catchError((dynamicError) {
      });
      print("$responseindegrents");
    }

    for (var i in steps) {
      responsesteps = await dio
          .post(Constants.ADDINSTRUCTIONAPI,
              data: {
                Constants.INSTRUCTION: i.toString(),
                Constants.RECIPEID: photoId.toString().trim()
              },
              options: Options(headers: map))
          .catchError((dynamicError) {
      });
      print("$responsesteps");

    }
    if (responsesteps.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    }

  }


  return loginModel;
}
