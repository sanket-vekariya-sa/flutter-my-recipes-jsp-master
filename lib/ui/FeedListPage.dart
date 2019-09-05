import 'dart:io';

import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Dashboard.dart';

class FeedListPage extends StatefulWidget {
  int loginData;

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<FeedListPage> {
  var _feedDetails = <ItemDetailsFeed>[];
  Future<ItemDetailsFeed> feed;

  String _searchText = "";
  var names = <ItemDetailsFeed>[]; // names we get from API
  var filteredNames = <ItemDetailsFeed>[];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Home');
  final TextEditingController _filter = new TextEditingController();

  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      key: login_state,
      body: FutureBuilder<dynamic>(
        future: _loadData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text(
                'no data available',
                textAlign: TextAlign.center,
              );
            case ConnectionState.active:
              return null;
            case ConnectionState.waiting:
              return SpinKitFadingCircle(color: Colors.pink);
            case ConnectionState.done:
              return _buildRow();
          }
          return null;
        },
      ),
    );
  }

  _loadData() async {
//    HomeFeedAPI(context);
    String feedDetailsURL = "http://35.160.197.175:3006/api/v1/recipe/feeds";
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader:
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
    };
    var response1 =
        await dio.get(feedDetailsURL, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      final itemDetailsfeed = new ItemDetailsFeed(
          memberJSON["name"],
          memberJSON["photo"],
          memberJSON["preparationTime"],
          memberJSON["serves"],
          memberJSON["complexity"],
          false);
      _feedDetails.add(itemDetailsfeed);
      names.add(itemDetailsfeed);
      filteredNames = names;
      //}
    }
  }

  _HomeScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = TextFormField(
          textInputAction: TextInputAction.done,
          controller: _filter,
          autofocus: true,
          decoration: InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
          onFieldSubmitted: (term) {
            FocusScope.of(context).unfocus();
          },
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = Text('Home');
        _filter.clear();
      }
    });
  }

  Widget _buildRow() {
    if (!(_searchText.isEmpty)) {
      var tempList = <ItemDetailsFeed>[];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .getName()
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return new ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: new ListTile(
              onTap: () {
                navigateToSubPage(context, index, _feedDetails);
              },
              title: new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Stack(
                      children: <Widget>[
                        new Image.network(
                          filteredNames[index].photo,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          height: 180,
                        ),
                        IconButton(
                          alignment: Alignment.topRight,
                          icon: Icon(
                              filteredNames[index].like
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: filteredNames[index].like
                                  ? Colors.red
                                  : Colors.grey),
                          onPressed: () => _feedDetails[index].like =
                              !_feedDetails[index].like,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 10),
                      child: new Text(filteredNames[index].name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 5),
                      child: new Text(filteredNames[index].name,
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
                                    filteredNames[index].preparationTime,
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
                                    filteredNames[index].complexity,
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
                                    "${filteredNames[index].serves} people",
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
            ),
          ),
        );
      },
    );
  }
}

Future navigateToSubPage(context, int, list) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => DashBoard(int, list)));
}
