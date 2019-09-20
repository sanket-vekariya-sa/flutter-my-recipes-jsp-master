import 'package:Flavr/ui/WishList.dart';
import 'package:Flavr/ui/FeedScreen.dart';
import 'package:Flavr/ui/ProfileScreen.dart';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String text;

  HomeScreen(this.text);

  @override
  _HomeScreenState createState() => _HomeScreenState(text);
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  String text;
  var Constants = CONSTANTS();

  _HomeScreenState(this.text);

  String appBarTitleText = 'Home';
  final widgetOptions = [
    new FeedScreen(),
    new WishList(),
    new ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(Constants.APPTITLEHOME)),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_dining), title: Text(Constants.APPTITLEWISHLIST)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text(Constants.APPTITLEPROFILE)),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    if (index == 0) {
      appBarTitleText = Constants.APPTITLEHOME;
    } else if (index == 1) {
      appBarTitleText = Constants.APPTITLEWISHLIST;
    } else if (index == 2) {
      //appBarTitleText = 'Favourites';
      appBarTitleText = Constants.APPTITLEPROFILE;
    }

    setState(() {
      selectedIndex = index;
    });
  }
}
