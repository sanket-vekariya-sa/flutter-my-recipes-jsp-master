
import 'package:Flavr/ui/DetailScreen.dart';
import 'package:flutter/material.dart';

Future navigateToSubPage(context, int, list) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => DetailScreen(int, list)));
}