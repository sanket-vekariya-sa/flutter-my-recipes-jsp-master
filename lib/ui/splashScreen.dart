import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int splashDuration = 2;

countDownTime() async {
  return Timer(
      Duration(seconds: splashDuration),
          () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Navigator.of(context).pushReplacementNamed('/LoginScreen');
      }
  );
}

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
void initState() {
  super.initState();
  countDownTime();
}

  @override
  Widget build(BuildContext context) {
   return new DecoratedBox(
  decoration: new BoxDecoration(
    image: new DecorationImage(
      image: new AssetImage('images/splashscreen_img.png'),
      fit: BoxFit.fill

    ),
  ),
);
  }
}