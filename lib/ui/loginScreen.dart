import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Flavr/apis/loginAPI.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocus = FocusNode();

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please Enter Valid Email';
    else
      return null;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTextFields() {
    return new Form(
        key: _formKey,
        child:new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, right: 40.0, bottom: 10.0, left: 40.0),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: new BorderSide(color: Colors.black),
                  ),
                ),
                onFieldSubmitted: (term){
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                validator: validateEmail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 40.0, bottom: 20.0, left: 40.0),
              child: TextFormField(
                focusNode: _passwordFocus,
                  obscureText: true,
                  controller: _passwordController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: new BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  }),
            ),

          ],
        )
    );
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
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Text(
                    'LOG IN',
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
                    'Good to see you again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 15.0),
                  ),
                ),
                _buildTextFields()
                ,Padding(
                  padding: const EdgeInsets.only(right: 40.0, left: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40.00,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {

                        if (_formKey.currentState.validate()) {

                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          loginAPI(context, _emailController.text,
                              _passwordController.text);
                        }
                      },
                      child: Text("LOG IN"),
                      color: Colors.orange,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
