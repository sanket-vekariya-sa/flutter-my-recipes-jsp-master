import 'package:Flavr/apis/loginAPI.dart';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocus = FocusNode();
  final Constansts = CONSTANTS();
  bool _obscureText = true;

  String validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return Constansts.ERROREMAIL;
    else
      return null;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildTextFields() {
    return new Form(
        key: _formKey,
        child: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, right: 40.0, bottom: 10.0, left: 40.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: Constansts.HINTEMAIL,
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: new BorderSide(color: Colors.black),
                  ),
                ),
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                validator: validateEmail,
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.only(right: 40.0, bottom: 20.0, left: 40.0),
              child: TextFormField(
                  textInputAction: TextInputAction.done,
                  focusNode: _passwordFocus,
                  obscureText: _obscureText,
                  controller: _passwordController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      labelText: Constansts.HINTPASSWORD,
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: new BorderSide(color: Colors.black),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: _toggle,
                        color: _obscureText ? Colors.blueGrey : Colors.black,
                      )),
                  validator: (value) {
                    if (value.isEmpty) {
                      return Constansts.ERRORPASSWORD;
                    }
                    return null;
                  }),
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
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          body: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text(
                        Constansts.STRINGLOGIN,
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
                        Constansts.LOGINMSG,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 15.0),
                      ),
                    ),
                    _buildTextFields(),
                    Padding(
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
                          child: Text(Constansts.STRINGLOGIN),
                          color: Colors.black,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 40),
                      child: Text(
                        Constansts.FORGETPASSWORD,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
