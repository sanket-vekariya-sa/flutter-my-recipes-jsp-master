 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Flavr/apis/loginAPI.dart';
 class Profile extends StatefulWidget {
 @override
  State<StatefulWidget> createState() {
    return new ProfileScreenState();
  }
 }
class ProfileScreenState extends State<Profile> {
  @override
  void initState() {
    super.initState();
   }
  Widget _buildTextFields() {
    return new Form(
            child: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 10.0, bottom: 10.0, left: 10.0),
              child:Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
                      )
                  )),
            ),


    Padding(
    padding: const EdgeInsets.only(
    top: 10.0),
            child: Text("jm1@example.com",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 15.0)
            ),),
//
            Padding(
              padding:
              const EdgeInsets.only(top:10.0),
              child: Text("Enjoy New Dishes",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15.0)),
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
                '/HomeScreen', (Route<dynamic> route) => false);
          } else {
            return Navigator.of(context).pushReplacementNamed('/HomeScreen');
          }
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               Padding(
                  padding: const EdgeInsets.only(top:100.0),
                  child: Text(
                    'Hello Foodie',
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
                    'Delicious Recipes App',
                    textAlign: TextAlign.center,
                   style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 15.0),
                 ),
               ),
                _buildTextFields(),
                Padding(
                  padding: const EdgeInsets.only(top:20.0),

                  child: SizedBox(
                    width: double.infinity,
                    height: 50.00,
                    child: RaisedButton(


                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/HomeScreen');
                      },
                      child: Text("Go to Recipe List", textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 15.0)),
                      color: Colors.orange,
                      textColor: Colors.white,

                   ),

                 ),
               ),
              ],
           ),
         ),
        ));
  }}
