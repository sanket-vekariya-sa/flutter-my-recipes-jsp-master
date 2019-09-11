import 'package:flutter/material.dart';
import 'package:Flavr/ui/Dining.dart';
import 'package:Flavr/ui/Farvorites.dart';
import 'package:Flavr/ui/FeedListPage.dart';
import 'package:Flavr/ui/Profile.dart';
import 'package:Flavr/ui/homeScreen.dart';
import 'package:Flavr/ui/splashScreen.dart';
import 'package:Flavr/ui/loginScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "MyRecipes",
      theme: new ThemeData(scaffoldBackgroundColor: Colors.lightBlue[100]),
       debugShowCheckedModeBanner : false,
      routes: <String,WidgetBuilder>{
        "/HomeScreen": (BuildContext context) => HomeScreen("email id"),
        "/LoginScreen": (BuildContext context) => LoginScreen(),
        "/FeedListPage": (BuildContext context) => FeedListPage(),
        "/Favorites" : (BuildContext context) => Favorites(),
        "/Profile" : (BuildContext context) => Profile(),
        "/Dining" : (BuildContext context) => Dining(),
      },
      home:
      SplashScreen(),



    );
  }
}


