import 'package:flutter/material.dart';
import 'package:Flavr/model/ItemDetailsFeed.dart';


import 'package:shimmer/shimmer.dart';
class Favorites extends StatefulWidget{
  int loginData;



  @override
  _FavroitesScreen createState() => new _FavroitesScreen();
}

class _FavroitesScreen extends State<Favorites> {
  var _feedDetails = <ItemDetailsFeed>[];
  Widget _appBarTitle = new Text('Wishlist');
  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      resizeToAvoidBottomPadding: false,
      key: login_state,
      body: FutureBuilder<dynamic>(
        future: _getResults(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ListView.builder(
              itemCount: 10,
              // Important code
              itemBuilder: (context, index) =>
                  Shimmer.fromColors(
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                      child: ListItem(index: -1)),
            );
          }
          return ListView.builder(
          itemCount: snapshot.data.length,
    itemBuilder: (context, index) => ListItem(index: index),
    );
    }),);
        }}


Future<List<int>> _getResults() async {
  await Future.delayed(Duration(seconds: 3));
  return List<int>.generate(10, (index) => index);
}


class ListItem extends StatelessWidget {
  final int index;
  const ListItem({Key key, this.index});
  @override
  Widget build(BuildContext context) {
//    return Container(
//      height: 60,
//      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
//      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
//      child: Row(
//        children: <Widget>[
//          Container(
//            width: 50.0,
//            height: 50.0,
//            margin: EdgeInsets.only(right: 15.0),
//            color: Colors.blue,
//          ),
//          index != -1
//              ? Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                'This is title $index',
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//              Text('This is more details'),
//              Text('One more detail'),
//            ],
//          )
//              : Expanded(
//            child: Container(
//              color: Colors.grey,
//            ),
//          )
//        ],
//      ),
//    );
    return Card(

      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),

      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new Image.network(
                "http://35.160.197.175:3006/uploads/e4621e53-c973-47de-9afd-1e12d79a191d.jpg",
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 180,
              ),
              IconButton(
                alignment: Alignment.topRight,
                icon: Icon(Icons.favorite,
                    color: Colors.red  ),

              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 10),
            child: new Text("$index",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 5),
            child: new Text("$index",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: new Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                        Text(
                          "$index",
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.library_books,
                          color: Colors.grey,
                        ),
                        Text(
                          "$index",
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.local_dining,
                          color: Colors.grey,
                        ),
                        Text(
                          "$index people",
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
