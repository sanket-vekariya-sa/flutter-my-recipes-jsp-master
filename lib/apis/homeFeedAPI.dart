import 'dart:io';

import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future HomeFeedAPI(BuildContext context) async {
  ItemDetailsFeed itemDetailsFeed;
  var _feedDetails = <ItemDetailsFeed>[];
  final Constants = CONSTANTS();

  var dio = new Dio();
  Map<String, dynamic> map = {
    HttpHeaders.authorizationHeader:
    Constants.APITOKEN
  };
  var response = await dio.get(Constants.FEEDSAPI, options: Options(headers: map));

  if (response.statusCode == 200) {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  itemDetailsFeed = ItemDetailsFeed(
      response.data[Constants.RECIPEID],
      response.data[Constants.NAME],
      response.data[Constants.PHOTO],
      response.data[Constants.PREPARATIONTIME],
      response.data[Constants.SERVES],
      response.data[Constants.COMPLEXITY],
      false,
      response.data[Constants.YOUTUBEURL]);
  _feedDetails.add(itemDetailsFeed);

  return _feedDetails;
}