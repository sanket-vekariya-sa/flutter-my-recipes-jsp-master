import 'dart:async';
import 'dart:io';

import 'package:Flavr/values/CONSTANTS.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ProfileScreenState();
  }
}

Future<bool> saveImagePreference(String imgurl) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(CONSTANTS().IMAGEURL, imgurl);
  return pref.commit();
}

Future<String> getImagePreference() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String savedImage = pref.getString(CONSTANTS().IMAGEURL);
  return savedImage;
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _connectionStatus;
  final Connectivity _connectivity = new Connectivity();
  final Constants = CONSTANTS();
  StreamSubscription<ConnectivityResult> _connectionSubscription;
  var mail;
  File galleryFile;
  File imgFile;
  String savedImagenew = "";
  File getImageFile;
  String profileImage;
  String saveNetworkState;
  SharedPreferences pref;

  @override
  void initState() {
    getImagePreference().then(upDateImage);
    super.initState();
    _connectionSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = Constants.LIVE;
      });
    });

  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  Widget _buildTextFields() {
    return new Form(
        child: new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: displaySelectedFile(galleryFile),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: FutureBuilder<dynamic>(
            future: _loadName(),
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
                  return SpinKitFadingCircle(color: Colors.black);
                case ConnectionState.done:
                  return _buildRow();
              }
              return null;
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: FutureBuilder<dynamic>(
            future: _loadName(),
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
                  return SpinKitFadingCircle(color: Colors.black);
                case ConnectionState.done:
                  return _buildConnectionState();
              }
              return null;
            },
          ),
        ),
//
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(Constants.TEXTENJOY,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20.0)),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (Navigator.canPop(context)) {
            return Navigator.of(context).pushNamedAndRemoveUntil(
                '/LoginScreen', (Route<dynamic> route) => false);
          } else {
            return Navigator.of(context).pushReplacementNamed('/LoginScreen');
          }
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    Constants.TEXTHELLO,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 30.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    Constants.TEXTAPPDEC,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                ),
                _buildTextFields(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.00,
                    child: RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {
                        clearPref();
                        Navigator.of(context)
                            .pushReplacementNamed('/LoginScreen');
                      },
                      textColor: Colors.white,
                      child: Text(Constants.LOGOUT,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 15.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: imageSelectorGallery,
            backgroundColor: Colors.black,
            tooltip: Constants.SELECTIMAGE,
            child: new Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
          ),
        ));
  }

  _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mail = prefs.getString("mail");
  }

  _loadLocalProfileImage() async {
    pref = SharedPreferences.getInstance() as SharedPreferences;
    pref.setString(Constants.IMAGEURL, galleryFile.path);
    imgFile = await galleryFile.copy(galleryFile.path);
  }

  Widget _buildRow() {
    return new Text(mail.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.black, fontSize: 25.0));
  }

  Widget _buildConnectionState() {
    return new Text(_connectionStatus,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.green, fontSize: 25.0));
  }

  imageSelectorGallery() async {
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200.0,
      maxWidth: 200.0,
    );

    setState(() {
      displaySelectedFile(galleryFile);
    });
  }

  Future<Null> initConnectivity() async {
    String connectionStatus;

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = Constants.CONNECTIONMSG;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
    });

    if (_connectionStatus == Constants.CONNECTIONMOBLIE ||
        _connectionStatus == Constants.CONNECTIONWIFI) {
      connectionStatus = Constants.CONNECTIONONLINE;
    } else {
      connectionStatus = Constants.CONNECTIONOFFLINE;
    }
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
        height: 200.0,
        width: 200.0,
        child: file == null
            ? new CircleAvatar(
                backgroundImage: new AssetImage('images/profile.png'),
                radius: 200.0,
              )
            : new CircleAvatar(
                backgroundImage: new FileImage(file),
                radius: 200.0,
              ));
  }

  void upDateImage(String value) {
    setState(() {
      this.savedImagenew = value;
    });
  }

  void clearPref() async {
    SharedPreferences loginprefs = await SharedPreferences.getInstance();
    loginprefs.clear();
  }
}
