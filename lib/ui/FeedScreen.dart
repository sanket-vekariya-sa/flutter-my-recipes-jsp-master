import 'dart:io';

import 'package:Flavr/apis/cookingListAPI.dart';
import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:Flavr/ui/Skelton.dart';
import 'package:Flavr/utils/CustomNavigation.dart';
import 'package:Flavr/utils/Permissions.dart';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:speech_recognition/speech_recognition.dart';

class FeedScreen extends StatefulWidget {
  int loginData;
  var likedFeed = <ItemDetailsFeed>[];

  @override
  _FeedScreenState createState() => new _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var _feedDetails = <ItemDetailsFeed>[];
  Future<ItemDetailsFeed> feed;
  var Constants = CONSTANTS();
  var likedList = FeedScreen().likedFeed;
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String _searchText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => filter.text = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  var names = <ItemDetailsFeed>[]; // names we get from API
  var filteredNames = <ItemDetailsFeed>[];
  Icon _searchIcon = new Icon(Icons.search);
  Icon _voiceSearchIcon = new Icon(Icons.keyboard_voice);

  Widget _appBarTitle = new Text('Home');

  final TextEditingController filter = new TextEditingController();

  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/AddRecipe');
        },
        backgroundColor: Colors.black,
        tooltip: Constants.TEXTADDRECIPE,
        child: new Icon(
          Icons.playlist_add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: _appBarTitle,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
          ),
          new IconButton(
            icon: _voiceSearchIcon,
            onPressed: () {
              microphonePermission();
              _voiceSearchPressed();
            },
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: RefreshIndicator(
        key: login_state,
        onRefresh: _refresh,
        child: FutureBuilder<dynamic>(
          future: _loadData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text(
                  Constants.NODATAMSG,
                  textAlign: TextAlign.center,
                );
              case ConnectionState.active:
                return null;
              case ConnectionState.waiting:
                return buildRowLoading(context);
              case ConnectionState.done:
                return _buildRow(context);
            }
            return null;
          },
        ),
      ),
    );
  }

  Future<Null> _refresh() {
    return _loadData().then((_FeedListPageState) {
      setState(() => initSpeechRecognizer());
    });
  }

  Future _loadData() async {
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader: Constants.APITOKEN
    };
    var response1 =
        await dio.get(Constants.FEEDSAPI, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      var isInCookingList = false;
      if (memberJSON[Constants.INCOOKINGLIST] == 1) {
        isInCookingList = true;
      }

      final itemDetailsfeed = new ItemDetailsFeed(
          memberJSON[Constants.RECIPEID],
          memberJSON[Constants.NAME],
          memberJSON[Constants.PHOTO],
          memberJSON[Constants.PREPARATIONTIME],
          memberJSON[Constants.SERVES],
          memberJSON[Constants.COMPLEXITY],
          isInCookingList,
          memberJSON[Constants.YOUTUBEURL]);
      _feedDetails.add(itemDetailsfeed);
      names.add(itemDetailsfeed);
      filteredNames = names;
    }
  }

  _HomeScreenState() {
    filter.addListener(() {
      setState(() {
        _searchText = filter.text;
      });
    });
  }

  void _voiceSearchPressed() {
    if (_isAvailable && !_isListening)
      _speechRecognition
          .listen(locale: Constants.ENGLISHLANGUAGE)
          .then((result) => filter.text = result);

    setState(() {
      if (this._voiceSearchIcon.icon == Icons.keyboard_voice) {
        this._voiceSearchIcon = new Icon(Icons.close);
        this._appBarTitle = TextFormField(
          textInputAction: TextInputAction.done,
          controller: filter,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: new Icon(Icons.settings_voice),
            hintText: Constants.HINTLISTINIG,
          ),
          onFieldSubmitted: (term) {
            filter.text = _searchText;
            FocusScope.of(context).unfocus();
          },
        );
        _HomeScreenState();
      } else {
        _isAvailable = true;
        this._searchIcon = Icon(Icons.search);
        this._voiceSearchIcon = new Icon(Icons.keyboard_voice);
        this._appBarTitle = Text(Constants.APPTITLEHOME);
        filter.clear();
        _searchText = "";
      }
    });
  }

  Future _searchPressed() async {
    await setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = TextFormField(
          textInputAction: TextInputAction.done,
          controller: filter,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: Constants.HINTSEARCH,
          ),
          onFieldSubmitted: (term) {
            _searchText = filter.text;
            FocusScope.of(context).unfocus();
          },
        );
        _HomeScreenState();
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = Text(Constants.APPTITLEHOME);
        filter.clear();
        _searchText = "";
      }
    });
  }

  Widget _buildRow(BuildContext context) {
    var counterProvider = Provider.of<ItemDetailsFeed>(context);
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
      itemCount: filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        if (filteredNames.length == 0) {
          return Scaffold(
            body: new FadeInImage.assetNetwork(
              placeholder: 'images/notFound.gif',
              image: filteredNames[index].photo,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: 175,
            ),
          );
        } else
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: SingleChildScrollView(
              child: new ListTile(
                onTap: () {
                  navigateToSubPage(
                      context, index, filteredNames);
                },
                title: new Card(
                  margin: EdgeInsets.only(left: 0, right: 0, top: 5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Stack(
                        children: <Widget>[
                          new FadeInImage.assetNetwork(
                            placeholder: 'images/loaderfood.gif',
                            image: filteredNames[index].photo,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                            height: 200,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            color: Colors.white,
                            child: IconButton(
                              alignment: Alignment.center,
                              icon: Icon(
                                  _feedDetails[index].like
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _feedDetails[index].like
                                      ? Colors.red
                                      : Colors.grey),
                              onPressed: () {
                                _feedDetails[index].like =
                                    !_feedDetails[index].like;
                                if (_feedDetails[index].like == true) {
                                  counterProvider.likeUpdate(true);
                                  addcookingListAPI(
                                      context, filteredNames[index].recipeId);
                                }
                                if (_feedDetails[index].like == false) {
                                  counterProvider.likeUpdate(false);

                                  removeCookingListAPI(
                                      context, filteredNames[index].recipeId);
                                }
                              },
                            ),
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
                                      "${filteredNames[index].serves} ${Constants.TEXTPEOPLE}",
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
