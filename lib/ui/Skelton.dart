import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildRowLoading(BuildContext context) {
  return new ListView.builder(
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: new ListTile(
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
                      Shimmer.fromColors(
                        baseColor: Colors.grey[400],
                        highlightColor: Colors.white,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/loaderfood.gif',
                          image:
                              "https://media.giphy.com/media/g8rEwOqIStrBC/giphy.gif",
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          height: 200,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 10),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'images/loaderfood.gif',
                        image:
                            "https://media.giphy.com/media/g8rEwOqIStrBC/giphy.gif",
                        fit: BoxFit.fitWidth,
                        width: 100,
                        height: 10,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'images/loaderfood.gif',
                        image:
                            "https://media.giphy.com/media/g8rEwOqIStrBC/giphy.gif",
                        fit: BoxFit.fitWidth,
                        width: 100,
                        height: 20,
                      ),
                    ),
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
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400],
                                  highlightColor: Colors.white,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'images/loaderfood.gif',
                                    image:
                                        "https://media.giphy.com/media/g8rEwOqIStrBC/giphy.gif",
                                    fit: BoxFit.fitWidth,
                                    width: 70,
                                    height: 20,
                                  ),
                                ),
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
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400],
                                  highlightColor: Colors.white,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'images/loaderfood.gif',
                                    image:
                                        "https://media.giphy.com/media/g8rEwOqIStrBC/giphy.gif",
                                    fit: BoxFit.fitWidth,
                                    width: 70,
                                    height: 20,
                                  ),
                                ),
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
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400],
                                  highlightColor: Colors.white,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'images/loaderfood.gif',
                                    image:
                                        "https://media.giphy.com/media/g8rEwOqIStrBC/giphy.gif",
                                    fit: BoxFit.fitWidth,
                                    width: 70,
                                    height: 20,
                                  ),
                                ),
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
