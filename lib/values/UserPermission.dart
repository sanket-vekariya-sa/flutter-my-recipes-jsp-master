import 'package:Flavr/ui/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:permission/permission.dart';

Future microphonePermission() async {
  var permissions =
  await Permission.getPermissionsStatus([PermissionName.Microphone]);
  if (permissions != PermissionStatus.allow) {
    Permission.requestPermissions([PermissionName.Microphone]);
  } else {}
}


Future navigateToSubPage(context, int, list) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => DetailScreen(int, list)));
}