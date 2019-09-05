import 'dart:async';
import 'dart:io';

import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<ItemDetailsFeed> HomeFeedAPI(BuildContext context) async {
  ItemDetailsFeed itemDetailsFeed;
  final url = "http://35.160.197.175:3006/api/v1/recipe/feeds";

  var dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
  };
  var response = await dio.get(url, options: Options(headers: map));

  if (response.statusCode == 200) {
    print("called if loop");
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  itemDetailsFeed = ItemDetailsFeed(
      response.data["name"],
      response.data["photo"],
      response.data["preparationTime"],
      response.data["serves"],
      response.data["complexity"],
      false);
  return itemDetailsFeed;
}
