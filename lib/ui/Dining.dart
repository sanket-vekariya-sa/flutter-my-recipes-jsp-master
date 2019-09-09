import 'dart:io';

import 'package:Flavr/apis/addRecipeAPI.dart';
import 'package:Flavr/apis/loginAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:image_picker/image_picker.dart';

class Dining extends StatefulWidget {
  int loginData;

  @override
  _DiningScreen createState() => new _DiningScreen();
}

class _DiningScreen extends State<Dining> {
  //GlobalKey<ScaffoldState> add_inputs = new GlobalKey<ScaffoldState>();
  final addInputs = GlobalKey<FormState>();
  Widget _appBarTitle = new Text('Add New Recipe');
  List<String> _indergentList = new List<String>();
  String dropdownValue = 'Easy';
  List<String> _stepList = new List<String>();
  List<String> _tags = new List<String>();
  File galleryFile;
  File cameraFile;
  double _fontSize = 25;
  final TextEditingController _indergrent = TextEditingController();
  final TextEditingController _step = TextEditingController();
  final TextEditingController _nameofRecipe = TextEditingController();
  //final TextEditingController _complexicty = TextEditingController();
  final TextEditingController _timeRequired = TextEditingController();
  final TextEditingController _serves = TextEditingController();
  final TextEditingController _youtubeUrl = TextEditingController();

  Widget _buildTextFields() {
    return new Form(
        key: addInputs,
        child: new Card(
          child:        new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                    controller: _nameofRecipe,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Name Of Recipe*',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: new BorderSide(color: Colors.orange),
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
                    right: 10.0, bottom: 2.0, left: 10.0, top: 5.0),
                child: TextFormField(
                    controller: _timeRequired,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Time Required*',
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
                padding: EdgeInsets.all(10.0),
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
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                    controller: _serves,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'No of Serves*',
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
          ) ,
        ),);
  }


  Widget _buildTextFieldYouTubeUrl() {
    return new Form(
        child: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _youtubeUrl,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'YouTube Url(Optional)',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: new BorderSide(color: Colors.orange),
                    ),
                  ),
                  ),
            ),

          ],
        ));
  }
  Widget _buildTags() {
    return new Form(
        child: new Padding(
          padding: EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              Tags(
                textField: TagsTextFiled(
                    textStyle: TextStyle(fontSize: _fontSize),
                    onSubmitted: (String str){
                      setState(() {
                        _tags.add(str);
                      });
                    }

                ),


//                itemCount: _tags.length,
//                itemBuilder: (int index){
//                  final item = _tags[index]
//                      return ItemTags(index: null, title: null)
//                },


              )
            ],
          ),

        ));
  }

  Widget _buildIngredit() {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Ingredients",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.orange),
                ),
              )

            ],
          )
          ,
          _listViewIndergents(context),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: _indergrent,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Add Ingredient',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.black),
                ),
                suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      var textis = _indergrent.text;
                      _indergentList.add(textis.toString());
                      setState(() {
                        _listViewIndergents(context);
                        _indergrent.clear();
                      });
                    }),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _listViewIndergents(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _indergentList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading:CircleAvatar(
            child: Text((index+1).toString(),style: TextStyle(color: Colors.white),),
            backgroundColor:Colors.orange,
            maxRadius: 12.0,
          ),
          title: Text(_indergentList[index]),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildSteps() {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Instructions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.orange),
                ),
              )

            ],
          ),
          _listViewSteps(context),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: _step,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Add Step',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.black),
                ),
                suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      var textis = _step.text;
                      _stepList.add(textis.toString());
                      setState(() {
                        _listViewSteps(context);
                        _step.clear();
                      });
                    }),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _listViewSteps(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _stepList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading:CircleAvatar(
            child: Text((index+1).toString(),style: TextStyle(color: Colors.white),),
            backgroundColor:Colors.orange,
            maxRadius: 12.0,
          ),
          title: Text(_stepList[index]),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 50.0,
        maxWidth: 50.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      setState(() {
        displaySelectedFile(galleryFile);
      });
    }

    return new Scaffold(
        appBar: AppBar(
          title: _appBarTitle,
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        resizeToAvoidBottomPadding: false,
        body: new SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                _buildTextFields(),
                _buildIngredit(),
                _buildSteps(),
                _buildTextFieldYouTubeUrl(),
                //_buildTags(),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Column(
                    children: <Widget>[
                      displaySelectedFile(galleryFile),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        onPressed: imageSelectorGallery,
                        child: Text("Select Image"),
                        color: Colors.orange,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40.00,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        if (addInputs.currentState.validate()) {
                          if (_indergentList.isEmpty && _stepList.isEmpty) {
                            print("Add Data Please");
                            showDialogSingleButton(context, "Add",
                                "Please Add Indergents and Steps", "OK");

                          }
                          if(galleryFile==null){
                            print("Add Data Please");
                            showDialogSingleButton(context, "Add Image",
                                "Please Add Image", "OK");
                          }

                          else {
                            print("Save data");
//                            showDialogSingleButton(context, "Save",
//                                "Add New Recipe", "OK");
                          addRecipeAPI(context,_nameofRecipe.text,_timeRequired.text,dropdownValue,_serves.text,_indergentList,_stepList,_youtubeUrl.text,galleryFile);
                          }
                        }
                      },
                      child: Text("Add Recipe"),
                      color: Colors.orange,
                      textColor: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 50.0,
      width: 50.0,
      child:
          file == null ? new Text('No image Selected') : new Image.file(file),
    );
  }
}
