
import 'package:permission/permission.dart';

Future microphonePermission() async {
  var permissions =
  await Permission.getPermissionsStatus([PermissionName.Microphone]);
  if (permissions != PermissionStatus.allow) {
    Permission.requestPermissions([PermissionName.Microphone]);
  } else {}
}