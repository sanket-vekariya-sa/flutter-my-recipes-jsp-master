import 'dart:io';
import 'package:Flavr/model/IngredientsModel.dart';
import 'package:Flavr/model/InstructionsModel.dart';
import 'package:Flavr/model/FeedListDetailsModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_player/youtube_player.dart';
import 'package:share/share.dart';


class RecipeDetailsScreen extends StatefulWidget {
  int index;
  List<ItemDetailsFeed> list;

  RecipeDetailsScreen(this.index, this.list);

  @override
  _RecipeDetailsScreenState createState() => new _RecipeDetailsScreenState(index, list);
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  int data;
  int newindex;
  List<ItemDetailsFeed> list;

  var indegrents;
  var insturctions;

  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();

  _RecipeDetailsScreenState(this.data, this.list);

  var _feedDetails = <IngredientsDetailsFeed>[];
  var _instructionDetails = <InstructionDetailsFeed>[];
  VideoPlayerController _videoController;
  var isPlaying = false;

  Widget _listViewIndergents() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: _feedDetails.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            maxRadius: 12.0,
          ),
          title: Text(_feedDetails[index].ingredient),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _listViewSteps() {
    final int a = _instructionDetails.length;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: a,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            maxRadius: 12.0,
          ),
          title: Text(
            _instructionDetails[index].instruction,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.blue,
              title: Text(list[data].getName().toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              actions: <Widget>[
                new IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    _shareRecipe();
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      child: list[data].youtubeUrl == ""
                          ? Image.network(
                        list[data].photo,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      )
                          : Stack(
                        children: <Widget>[
                          YoutubePlayer(
                            context: context,
                            controlsColor: ControlsColor(
                                buttonColor: Colors.amber,
                                playPauseColor: Colors.red,
                                progressBarBackgroundColor: Colors.pink,
                                seekBarPlayedColor: Colors.white),
                            source: list[data].youtubeUrl,
                            quality: YoutubeQuality.MEDIUM,
                            loop: true,
                            autoPlay: false,
                            hideShareButton: true,
                            showThumbnail: true,
                            startFullScreen: false,
                            showVideoProgressbar: true,
                            keepScreenOn: false,
                            callbackController: (controller) {
                              _videoController = controller;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                  child: new Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            list[data].getName(),
                            style:
                            TextStyle(fontSize: 15.0, color: Colors.grey),
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
                                color: Colors.blue,
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
                  color: Colors.blue,
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "INGREDIENTS",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
//            _listViewIndergents(context),
                Container(
                  color: Colors.white,
                  child: FutureBuilder<dynamic>(
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
                          return SpinKitFadingCircle(color: Colors.blue);
                        case ConnectionState.waiting:
                          return SpinKitFadingCircle(color: Colors.pink);
                        case ConnectionState.done:
                          newindex = data;
                          return _listViewIndergents();
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "INSTRUCTIONS",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: FutureBuilder<dynamic>(
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
                        case ConnectionState.waiting:
                          return SpinKitFadingCircle(color: Colors.pink);
                        case ConnectionState.done:
                          newindex = data;
                          return _listViewSteps();
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _loadData() async {
    print("${list[data].recipeId}=====recipeId is===");
    String ingredientsURL =
        "http://35.160.197.175:3006/api/v1/recipe/${list[data].recipeId}/ingredients";
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
        memberJSON["ingredient"],
      );
      _feedDetails.add(ingreditentfeed);
    }

    indegrents = (_feedDetails[0].ingredient.replaceAll('[', '')).toString();
    indegrents = (indegrents.replaceAll(']', '')).toString();
  }

  _loadInstruction() async {
    String instructionsURL =
        "http://35.160.197.175:3006/api/v1/recipe/${list[data].recipeId}/instructions";
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
        memberJSON["instruction"],
      );
      _instructionDetails.add(instructionfeed);
    }

    print(
        "length response instruction : ${_instructionDetails[0].instruction}");
  }

  @override
  void initState() {
    super.initState();
  }

  void _shareRecipe() {
    if (list[data].youtubeUrl == "") {
      Share.share("Recipe : ${list[data].name}\n"
          "Searve : ${list[data].serves}\n"
          "Preparation Time : ${list[data].preparationTime}\n"
          "Complexity : ${list[data].complexity}\n");
    } else {
      Share.share("Recipe : ${list[data].name}\n"
          "Searve : ${list[data].serves}\n"
          "Preparation Time : ${list[data].preparationTime}\n"
          "Complexity : ${list[data].complexity}\n"
          "Youtube Link : ${list[data].youtubeUrl}");
    }
  }
}