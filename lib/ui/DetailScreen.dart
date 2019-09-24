import 'dart:io';

import 'package:Flavr/model/IngredientsDetailsFeed.dart';
import 'package:Flavr/model/InstructionDetailsFeed.dart';
import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:Flavr/utils/ListViewWidget.dart';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share/share.dart';
import 'package:youtube_player/youtube_player.dart';

class DetailScreen extends StatefulWidget {
  int index;
  List<ItemDetailsFeed> list;

  DetailScreen(this.index, this.list);

  @override
  _DetailScreenState createState() => new _DetailScreenState(index, list);
}

class _DetailScreenState extends State<DetailScreen> {
  int data;
  int newindex;
  List<ItemDetailsFeed> list;
  final Constants = CONSTANTS();

  var indegrents;
  var insturctions;

  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();

  _DetailScreenState(this.data, this.list);

  var _feedDetails = <IngredientsDetailsFeed>[];
  var _instructionDetails = <InstructionDetailsFeed>[];
  VideoPlayerController _videoController;
  var isPlaying = false;

  Widget _noDataFound() {

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(Constants.NODATAFOUND,textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0),),
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
              backgroundColor: Colors.black,
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
                                        list[data].serves + Constants.TEXTPEOPLE,
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
                  color: Colors.black,
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Constants.TEXTINGREDENT,
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
                    key: login_state,
                    future: _loadData(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text(
                            Constants.NODATAMSG,
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.active:
                          return Text(
                            Constants.NODATAMSG,
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.waiting:
                          return SpinKitFadingCircle(color: Colors.pink);
                        case ConnectionState.done:
                          newindex = data;
                          if(_feedDetails.length == 0){
                            return _noDataFound();
                          }else{
                            return listViewIndergents(_feedDetails);
                          }

                          //return _listViewIndergents();
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Constants.TEXTINSTRUCTION,
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
                            Constants.NODATAMSG,
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.active:
                          return Text(
                            Constants.NODATAMSG,
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.waiting:
                          return SpinKitFadingCircle(color: Colors.pink);
                        case ConnectionState.done:
                          newindex = data;

                          if(_instructionDetails.length == 0){
                            return _noDataFound();
                          }else{
                            return listViewSteps(_instructionDetails);
                          }
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
    String ingredientsURL =
        "${Constants.GETINGREDENTSandINSTURCTIONSAPI}${list[data].recipeId}/ingredients";
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader:
          Constants.APITOKEN
    };
    var response1 =
        await dio.get(ingredientsURL, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      final ingreditentfeed = new IngredientsDetailsFeed(
        memberJSON[Constants.ID],
        memberJSON[Constants.INGREDENT],
      );
      _feedDetails.add(ingreditentfeed);
    }

    indegrents = (_feedDetails[0].ingredient.replaceAll('[', '')).toString();
    indegrents = (indegrents.replaceAll(']', '')).toString();
  }

  _loadInstruction() async {
    String instructionsURL =
        "${Constants.GETINGREDENTSandINSTURCTIONSAPI}${list[data].recipeId}/instructions";
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader:
          Constants.APITOKEN
    };
    var response1 =
        await dio.get(instructionsURL, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      final instructionfeed = new InstructionDetailsFeed(
        memberJSON[Constants.ID],
        memberJSON[Constants.INSTRUCTION],
      );
      _instructionDetails.add(instructionfeed);
    }

  }

  @override
  void initState() {
    super.initState();
  }

  void _shareRecipe() {
    if (list[data].youtubeUrl == "") {
      Share.share("Recipe : ${list[data].name}\n"
          "${Constants.HINTSERVES} : ${list[data].serves}\n"
          "${Constants.HINTTIME}: ${list[data].preparationTime}\n"
          "${Constants.COMPLEXITY} : ${list[data].complexity}\n");
    } else {
      Share.share("Recipe : ${list[data].name}\n"
          "${Constants.HINTSERVES} : ${list[data].serves}\n"
          "${Constants.HINTTIME} : ${list[data].preparationTime}\n"
          "${Constants.COMPLEXITY} : ${list[data].complexity}\n"
          "${Constants.TEXTYOUTUBELINK}: ${list[data].youtubeUrl}");
    }
  }
}
