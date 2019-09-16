import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future addcookingListAPI(BuildContext context, int id) async {

  final url = "http://35.160.197.175:3006/api/v1/recipe/add-to-cooking-list";
  Dio dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
  };
  final response = await dio.post(
      url,
      data: {"recipeId" : id}, options: Options(headers: map)).catchError(
          (dynamicError){
        print("called error loop");

      }

  );
  if (response.statusCode == 200) {
    print("sucess ==== $response");

  }

}

Future removeCookingListAPI(BuildContext context, int id) async {

  final url = "http://35.160.197.175:3006/api/v1/recipe/rm-from-cooking-list";
  Dio dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
  };
  final response = await dio.post(
      url,
      data: {"recipeId" : id}, options: Options(headers: map)).catchError(
          (dynamicError){
        print("called error loop");

      }

  );
  if (response.statusCode == 200) {
    print("sucess ==== $response");

  }

}