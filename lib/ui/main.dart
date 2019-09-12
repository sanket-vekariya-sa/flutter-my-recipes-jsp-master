import 'package:Flavr/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:Flavr/ui/AddRecipeScreen.dart';
import 'package:Flavr/ui/WishListScreen.dart';
import 'package:Flavr/ui/FeedListScreen.dart';
import 'package:Flavr/ui/ProfileScreen.dart';
import 'package:Flavr/ui/DashBoardScreen.dart';
import 'package:Flavr/ui/LoginScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "MyRecipes",
      debugShowCheckedModeBanner : false,
      routes: <String,WidgetBuilder>{
        "/LoginScreen": (BuildContext context) => LoginScreen(),
        "/DashBoardScreen": (BuildContext context) => DashBoardScreen("email id"),

        "/FeedListScreen": (BuildContext context) => FeedListScreen(),
        "/WishListScreen" : (BuildContext context) => WishListScreen(),
        "/ProfileScreen" : (BuildContext context) => ProfileScreen(),
        "/AddRecipeScreen" : (BuildContext context) => AddRecipeScreen(),
      },
      home:
      SplashScreen(),



    );
  }
}


