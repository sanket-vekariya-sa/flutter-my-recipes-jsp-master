import 'dart:async';
import 'dart:io';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future addcookingListAPI(BuildContext context, int id) async {
  final Constants = CONSTANTS();

  Dio dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
    Constants.APITOKEN
  };
  final response = await dio.post(
      Constants.ADDCOOKINGLISTAPI,
      data: {Constants.RECIPEID: id}, options: Options(headers: map)).catchError(
          (dynamicError){
      }

  );
  if (response.statusCode == 200) {
    print("$response");

  }

}

Future removeCookingListAPI(BuildContext context, int id) async {
  final Constants = CONSTANTS();
  Dio dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
    Constants.APITOKEN
  };
  final response = await dio.post(
      Constants.REMOVEFROMCOOKINGLISTAPI,
      data: {Constants.RECIPEID: id}, options: Options(headers: map)).catchError(
          (dynamicError){

      }

  );
  if (response.statusCode == 200) {
    print("$response");

  }

}