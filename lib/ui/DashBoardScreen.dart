import 'package:flutter/material.dart';
import 'package:Flavr/ui/AddRecipeScreen.dart';
import 'package:Flavr/ui/WishListScreen.dart';
import 'package:Flavr/ui/FeedListScreen.dart';
import 'package:Flavr/ui/ProfileScreen.dart';

class DashBoardScreen extends StatefulWidget {
  final String text;
  DashBoardScreen(this.text);
  @override
  _DashBoardScreenState createState() =>  _DashBoardScreenState(text);
}

class _DashBoardScreenState extends State<DashBoardScreen> {
    int selectedIndex = 0;
     String  text;

    _DashBoardScreenState(this.text);
String appBarTitleText ='Home';
  final widgetOptions = [
    new FeedListScreen(),
    new WishListScreen(),
    new ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
     }

   @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding : false,
//      appBar: AppBar(title: Text(appBarTitleText, style: TextStyle(color: Colors.black),),
//        backgroundColor: Colors.white,
//          centerTitle: true,
//        actions: <Widget>[
//        new IconButton( icon: new Icon(Icons.search), onPressed: () {
//
//        },),],
//        iconTheme: IconThemeData(color: Colors.black),
//        elevation:
//        Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
//      ),

       body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_dining), title: Text('Wishlist')),
           BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile')),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor:Colors.black ,
        selectedItemColor: Colors.blue,

       onTap: onItemTapped,
      ),


    );
  }
  void onItemTapped(int index) {
    if(index == 0){
      appBarTitleText = 'Home';

    }else if(index == 1){
      appBarTitleText = 'Wishlist';

    }else if(index == 2){
      //appBarTitleText = 'Favourites';
      appBarTitleText = 'Profile';

   }
// else if(index == 3){
//      appBarTitleText = 'Profile';
//
//    }

    setState(() {
      selectedIndex = index;

    });
  }

}