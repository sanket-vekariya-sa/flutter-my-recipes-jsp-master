import 'package:Flavr/ui/Dining.dart';
import 'package:Flavr/ui/Farvorites.dart';
import 'package:Flavr/ui/FeedListPage.dart';
import 'package:Flavr/ui/Profile.dart';
import 'package:Flavr/ui/homeScreen.dart';
import 'package:Flavr/ui/loginScreen.dart';
import 'package:Flavr/ui/splashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "MyRecipes",
      theme: new ThemeData(
          scaffoldBackgroundColor: Colors.white70,
          bottomAppBarColor: Colors.white,
          cursorColor: Colors.grey,
          cardColor: Colors.white,
          hintColor: Colors.grey,
          focusColor: Colors.white,
          primaryColor: Colors.black,
          unselectedWidgetColor: Colors.grey,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
            body1: TextStyle(color: Colors.white),
            body2: TextStyle(color: Colors.white),
            subhead: TextStyle(color: Colors.white),
          ),
          secondaryHeaderColor: Colors.black),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/HomeScreen": (BuildContext context) => HomeScreen("email id"),
        "/LoginScreen": (BuildContext context) => LoginScreen(),
        "/FeedListPage": (BuildContext context) => FeedListPage(),
        "/Favorites": (BuildContext context) => Favourite(),
        "/Profile": (BuildContext context) => Profile(),
        "/Dining": (BuildContext context) => Dining(),
      },
      home: SplashScreen(),
    );
  }
}
