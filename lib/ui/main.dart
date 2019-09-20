import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:Flavr/ui/AddRecipe.dart';
import 'package:Flavr/ui/WishList.dart';
import 'package:Flavr/ui/FeedScreen.dart';
import 'package:Flavr/ui/ProfileScreen.dart';
import 'package:Flavr/ui/HomeScreen.dart';
import 'package:Flavr/ui/LoginScreen.dart';
import 'package:Flavr/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemDetailsFeed>(builder: (context) => ItemDetailsFeed.fromFeed(true)),
      ],
      child: new MaterialApp(
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

      ),
    );
  }
}
