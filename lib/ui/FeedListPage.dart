import 'package:flutter/material.dart';
import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';

class FeedListPage extends StatefulWidget {
  int loginData;

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<FeedListPage> {
  var _feedDetails = <ItemDetailsFeed>[];

  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      resizeToAvoidBottomPadding: false,
      key: login_state,
      body: FutureBuilder<dynamic>(
        future: _loadData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('no data available', textAlign: TextAlign.center,);
            case ConnectionState.active:
              return null;
            case ConnectionState.waiting:
              return SpinKitWanderingCubes(
                  color: Colors.pink, shape: BoxShape.rectangle);
            case ConnectionState.done:
              return _buildRow();
          }
          return null;
        },
      ),
    );
  }

  _loadData() async {
    String feedDetailsURL = "http://35.160.197.175:3006/api/v1/recipe/feeds";
    String recipeDetailsURL =
        "http://35.160.197.175:3006/api/v1/recipe/1/details";

    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader:
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
    };
    var response1 =
    await dio.get(feedDetailsURL, options: Options(headers: map));
    setState(() {
      for (var memberJSON in response1.data) {
        final itemDetailsfeed = new ItemDetailsFeed(
            memberJSON["name"],
            memberJSON["photo"],
            memberJSON["preparationTime"],
            memberJSON["serves"],
            memberJSON["complexity"]);
        _feedDetails.add(itemDetailsfeed);
      }
    });
  }

  Widget _buildRow() {
    return new ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: _feedDetails.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          onTap: () {
//            navigateToSubPage(context, index, _feedDetails);
          },
          title: new Card(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Image.network(
                  _feedDetails[index].photo,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: 180,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 10),
                  child: new Text(_feedDetails[index].name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 5),
                  child: new Text(_feedDetails[index].name,
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
                                _feedDetails[index].preparationTime,
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
                                _feedDetails[index].complexity,
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
                                "${_feedDetails[index].serves} people",
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
          ),
        );
      },
    );
  }

//  Widget _buildRow(int i) {
//    return new ListTile(
//      onTap: () {
//        navigateToSubPage(context, i);
//      },
//      title: new Text(
//        "${_feedDetails[i].name}",
//      ),
//      leading: new CircleAvatar(
//          backgroundColor: Colors.green,
//          backgroundImage: new NetworkImage(_feedDetails[i].photo)),
//    );
//  }

  @override
  void initState() {
    _loadData();
  }

//  Future navigateToSubPage(context, int, list) async {
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => DashBoard(int, list)));
//  }
}
