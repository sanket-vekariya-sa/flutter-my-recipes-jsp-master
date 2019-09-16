import 'package:flutter/material.dart';

class LoginModel with ChangeNotifier{
  final String email;
  final String password;

  LoginModel(this.email, this.password);

  LoginModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

}
