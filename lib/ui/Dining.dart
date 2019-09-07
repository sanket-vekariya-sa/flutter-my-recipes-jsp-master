import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shimmer/shimmer.dart';

class Dining extends StatefulWidget {
  int loginData;

  @override
  _DiningScreen createState() => new _DiningScreen();
}

class _DiningScreen extends State<Dining> {
  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();
  Widget _appBarTitle = new Text('Add New Recipe');

  String dropdownValue = 'Easy';

//save the result of gallery file
  File galleryFile;

//save the result of camera file
  File cameraFile;

//  @override
//  Widget build(BuildContext context) {
//
//    imageSelectorGallery() async {
//      galleryFile = await ImagePicker.pickImage(
//        source: ImageSource.gallery,
//        // maxHeight: 50.0,
//        // maxWidth: 50.0,
//      );
//      print("You selected gallery image : " + galleryFile.path);
//      setState(() {});
//    }
//
//    //display image selected from camera
//    imageSelectorCamera() async {
//      cameraFile = await ImagePicker.pickImage(
//        source: ImageSource.camera,
//        //maxHeight: 50.0,
//        //maxWidth: 50.0,
//      );
//      print("You selected camera image : " + cameraFile.path);
//      setState(() {});
//    }

  Widget _buildTextFields() {
    return new Form(
        child: new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(1.0),
          child: TextFormField(
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Name Of Recipe',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.black),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Name of Recipe';
                }
                return null;
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(
              right: 1.0, bottom: 2.0, left: 1.0, top: 5.0),
          child: TextFormField(
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Time Required',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.black),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Time';
                }
                return null;
              }),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Easy', 'Hard', 'Medium']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(1.0),
          child: TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'No of Serves',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.black),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter No of Serves';
                }
                return null;
              }),
        )
      ],
    ));
  }
  Widget _buildIngredit() {
    return new Form(
        child: new Column(
          children: <Widget>[
            Text("Indegreted",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: TextFormField(
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Add Indegret',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: new BorderSide(color: Colors.black),
                    ),
                    suffixIcon: IconButton(icon: Icon(Icons.add), onPressed: null)
                  ),
                 ),
            )
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      setState(() {});
    }

    return new Scaffold(
        appBar: AppBar(
          title: _appBarTitle,
          centerTitle: true,
        ),
        resizeToAvoidBottomPadding: false,
        key: login_state,
        body: new SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                _buildTextFields(),
                new RaisedButton(
                  child: new Text('Select Image from Gallery'),
                  onPressed: imageSelectorGallery,
                ),
                displaySelectedFile(galleryFile),
                _buildIngredit(),
              ],
            ),
          ),
//        child: new Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//
//
//          ],
//        ),
        ));
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 200.0,
      width: 400.0,
      child: new Image.file(file),
    );
  }
}
