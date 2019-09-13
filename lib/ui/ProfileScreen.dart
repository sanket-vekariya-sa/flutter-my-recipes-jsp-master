import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ProfileScreenState();
  }
}



Future<bool> saveImagePreference(String imgurl) async{
  SharedPreferences pref= await SharedPreferences.getInstance();
      pref.setString("imgUrl", imgurl);
  return pref.commit();
}
Future<String> getImagePreference() async{
  SharedPreferences pref= await SharedPreferences.getInstance();
  String savedImage = pref.getString("imgUrl");
  return savedImage;
}


class _ProfileScreenState extends State<ProfileScreen> {
  String _connectionStatus;
  final Connectivity _connectivity = new Connectivity();
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
            _connectionStatus = "Live";
          });
        });
    print("Initstate : $_connectionStatus");
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
            /*Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, bottom: 10.0, left: 10.0),
          child: Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")))),
        ),*/
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: displaySelectedFile(galleryFile),

            ),
//        RaisedButton(
//          shape: RoundedRectangleBorder(
//              borderRadius: new BorderRadius.circular(10.0)),
//          onPressed: imageSelectorGallery,
//          child: Text("Select Image"),
//          color: Colors.orange,
//          textColor: Colors.white,
//        ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FutureBuilder<dynamic>(
                future: _loadName(),
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
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FutureBuilder<dynamic>(
                future: _loadName(),
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
                      return _buildConnectionState();
                  }
                  return null;
                },
              ),
            ),
//
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Enjoy New Dishes",
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
                '/DashBoardScreen', (Route<dynamic> route) => false);
          } else {
            return Navigator.of(context).pushReplacementNamed(
                '/DashBoardScreen');
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
                    'Hello Foodie',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 30.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Delicious Recipes App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                ),
                _buildTextFields(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.00,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        clearPref();
                        Navigator.of(context).pushReplacementNamed('/LoginScreen');
                      },
                      child: Text("Logout",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 15.0)),
                      color: Colors.blue,
                      textColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: imageSelectorGallery,
            tooltip: 'Pick Image',
            child: new Icon(Icons.add_a_photo, color: Colors.black,),
            backgroundColor: Colors.blue,
          ),
        ));
  }

  _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mail = prefs.getString("mail");
  }

  _loadLocalProfileImage() async {
    pref = SharedPreferences.getInstance() as SharedPreferences;
    pref.setString('imgUrl', galleryFile.path);
    imgFile = await galleryFile.copy(galleryFile.path);
  }


  Widget _buildRow() {
    return new Text(mail.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.blue, fontSize: 25.0));
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


    // String img= galleryFile.toString();
    //  saveImagePreference(galleryFile.path);
    print("You selected gallery image : " + galleryFile.path);

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
      connectionStatus = "Internet connectivity failed";
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
    });
    print("InitConnectivity : $_connectionStatus");
    if (_connectionStatus == "ConnectivityResult.mobile" ||
        _connectionStatus == "ConnectivityResult.wifi") {
      connectionStatus = "Online";
    } else {
      connectionStatus = "Ofline";
    }
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
        height: 200.0,
        width: 200.0,
        child:
        file == null ? new CircleAvatar(
          backgroundImage: new AssetImage('images/profileimage.jpg'),
          radius: 200.0,)
            : new CircleAvatar(
          backgroundImage: new FileImage(file), radius: 200.0,));
  }


  void upDateImage(String value) {
    setState(() {
      this.savedImagenew = value;
    });
  }

  void clearPref () async{
    SharedPreferences loginprefs = await SharedPreferences.getInstance();
    loginprefs.clear();
  }
}