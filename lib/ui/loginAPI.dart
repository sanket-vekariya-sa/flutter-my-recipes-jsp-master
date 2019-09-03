import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Flavr/ui/loginModel.dart';

Future<LoginModel> loginAPI(BuildContext context, String email, String password) async {
  LoginModel loginModel;
  final url = "http://35.160.197.175:3006/api/v1/user/login";

  Dio dio = new Dio();
  final response = await dio.post(
    url,
     data: {"email": email,"password": password});
      
  if (response.statusCode == 200) {
       Navigator.of(context).pushReplacementNamed('/HomeScreen');
    }
    else {
          showDialogSingleButton(context, "Unable to Login", "Please Try Again", "OK");
    return null;
  }
  loginModel = LoginModel(
        response.data["email"],
        response.data["password"],
       );
       return loginModel;
}
void showDialogSingleButton(BuildContext context, String title, String message, String buttonLabel) {
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
