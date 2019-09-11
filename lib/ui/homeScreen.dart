import 'package:flutter/material.dart';
import 'package:Flavr/ui/Dining.dart';
import 'package:Flavr/ui/Farvorites.dart';
import 'package:Flavr/ui/FeedListPage.dart';
import 'package:Flavr/ui/Profile.dart';

class HomeScreen extends StatefulWidget {
  final String text;
  HomeScreen(this.text);
  @override
  _HomeScreenState createState() =>  _HomeScreenState(text);
}

class _HomeScreenState extends State<HomeScreen> {
    int selectedIndex = 0;
     String  text;

    _HomeScreenState(this.text);
String appBarTitleText ='Home';
  final widgetOptions = [
    new FeedListPage(),
    new Favorites(),
    new Profile(),
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
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushReplacementNamed('/Dining');
        },
        tooltip: 'Add Recipe',
        child: new Icon(Icons.playlist_add, color: Colors.black,),
        backgroundColor: Colors.blue,
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