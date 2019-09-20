import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int splashDuration = 2;

  countDownTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Timer(Duration(seconds: splashDuration), () {
      var a = prefs.getBool("authenticated");
      if (a == null) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Navigator.of(context).pushReplacementNamed('/LoginScreen');
      } else {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Navigator.of(context).pushReplacementNamed('/HomeScreen');
      }
    });
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
            fit: BoxFit.fill),
      ),
    );
  }
}
