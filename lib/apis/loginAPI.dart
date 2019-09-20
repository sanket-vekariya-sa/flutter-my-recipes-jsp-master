import 'dart:async';

import 'package:Flavr/model/LoginModel.dart';
import 'package:Flavr/ui/HomeScreen.dart';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LoginModel> loginAPI(
    BuildContext context, String email, String password) async {
  LoginModel loginModel;
  var Constants = CONSTANTS();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Dio dio = new Dio();
  final response = await dio.post(Constants.LOGINAPI,
      data: {Constants.EMAILKEY: email, Constants.PASSWORDKEY: password}).catchError((dynamicError) {
    prefs.setBool('authenticated', false);
    showDialogSingleButton(
        context, Constants.ERRORLOGIN, Constants.TRYAGINMSG, Constants.TEXTOK);
  });

  if (response.statusCode == 200) {
    await prefs.setBool('authenticated', true);
    prefs.setString(Constants.EMAIL, email.toString());

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(email),
        ));
  }

  loginModel = LoginModel(
    response.data[Constants.EMAILKEY],
    response.data[Constants.PASSWORDKEY],
  );
  return loginModel;
}

void showDialogSingleButton(
    BuildContext context, String title, String message, String buttonLabel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(message),
        actions: <Widget>[
          new FlatButton(
            child: new Text(buttonLabel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
