import 'dart:io';
import 'dart:async';
import 'package:Flavr/model/IngredientsDetailsFeed.dart';
import 'package:Flavr/model/InstructionDetailsFeed.dart';
import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashBoard extends StatefulWidget {
  int index;
  List<ItemDetailsFeed> list;

  DashBoard(this.index, this.list);

  @override
  _DashBoardState createState() => new _DashBoardState(index, list);

}

class _DashBoardState extends State<DashBoard> {
  int data;
  int newindex;
  List<ItemDetailsFeed> list;

  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();

  _DashBoardState(this.data, this.list);


   var _feedDetails = <IngredientsDetailsFeed>[];
  var _instructionDetails = <InstructionDetailsFeed>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.toString()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            Image.network(list[data].photo),

            Container(
              color: Colors.white30,
              padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        list[data].getName(),
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        list[data].getName(),
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.timer),
                                  Text(
                                    list[data].preparationTime,
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
                                children: <Widget>[
                                  Icon(Icons.library_books),
                                  Text(
                                    list[data].complexity,
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
                                children: <Widget>[
                                  Icon(Icons.fastfood),
                                  Text(
                                    list[data].serves + " people",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),

            Container(

              color: Colors.grey,
              width: double.infinity,
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "INGREDIENTS",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),

            FutureBuilder<dynamic>(
              key: login_state,
              future: _loadData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text(
                      'no data available',
                      textAlign: TextAlign.center,
                    );
                  case ConnectionState.active:
                    return Text(
                      'no data available',
                      textAlign: TextAlign.center,
                    );
                    return SpinKitFadingCircle(color: Colors.black);
                  case ConnectionState.waiting:
                    return SpinKitFadingCircle(color: Colors.pink);
                  case ConnectionState.done:
                    newindex = data;
                    return Text(

                      _feedDetails[newindex].ingredient,
                      textAlign: TextAlign.center,
                    );
                    return _buildRow();
                }
                return null;
              },
            ),

            Container(

              color: Colors.grey,
              width: double.infinity,
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "INSTRUCTIONS",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
            FutureBuilder<dynamic>(
             future: _loadInstruction(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text(
                      'no data available',
                      textAlign: TextAlign.center,
                    );
                  case ConnectionState.active:
                    return Text(
                      'no data available',
                      textAlign: TextAlign.center,
                    );
                    return SpinKitFadingCircle(color: Colors.black);
                  case ConnectionState.waiting:
                    return SpinKitFadingCircle(color: Colors.pink);
                  case ConnectionState.done:
                    newindex = data;
                    return Text(

                      _instructionDetails[newindex].instruction,
                      textAlign: TextAlign.center,
                    );
                    return _buildRow();
                }
                return null;
              },
            ),

//            FutureBuilder<dynamic>(
//              future: _loadData(),
//              builder: (context, snapshot) {
//                switch (snapshot.connectionState) {
//                  case ConnectionState.none:
//                    return Text(
//                      'no data available',
//                      textAlign: TextAlign.center,
//                    );
//                  case ConnectionState.active:
//                    return null;
//                  case ConnectionState.waiting:
//                    return SpinKitFadingCircle(color: Colors.pink);
//                  case ConnectionState.done:
//                    return _buildRow();
//                }
//                return null;
//              },
//            ),
// ListView(
// children: <Widget>[Text(_feedDetails.toString())],
// ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow() {
    return new ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: _feedDetails.length,
      itemBuilder: (BuildContext context, int index) {
        return
//          Text(_feedDetails[index].ingredient);

          new ListTile(
          title: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: new Text(
                    _feedDetails[index].ingredient,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
        );
      },
    );
  }

  _loadData() async {
    String ingredientsURL = "http://35.160.197.175:3006/api/v1/recipe/1/ingredients";
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader:
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
    };
    var response1 =
    await dio.get(ingredientsURL, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      final ingreditentfeed = new IngredientsDetailsFeed(
        memberJSON["id"],
        memberJSON["ingredient"],);
      _feedDetails.add(ingreditentfeed);
    }
    print("response : $response1");
    print("data response : ${response1.data}");
    print("data item response : ${_feedDetails[0].ingredient}");
    print("length response : ${_feedDetails.length}");

  }

  _loadInstruction() async {
    String instructionsURL = "http://35.160.197.175:3006/api/v1/recipe/1/instructions";
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader:
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
    };
    var response1 =
    await dio.get(instructionsURL, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      final instructionfeed = new InstructionDetailsFeed(
        memberJSON["id"],
        memberJSON["instruction"],);
      _instructionDetails.add(instructionfeed);
    }
  /*  print("response : $response1");
    print("data response : ${response1.data}");
    print("data item response : ${_feedDetails[0].ingredient}");
    print("length response : ${_feedDetails.length}");*/

  }
  @override
  void initState() {
    super.initState();
  }
}
