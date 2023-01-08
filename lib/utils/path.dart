import 'dart:io' show Directory, Platform, stdout;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:path_provider/path_provider.dart';

String appHomeDirectory() {
  var directory = Directory.current;
  debugPrint("current directory: ${directory.path}");
  return directory.path;
  // switch (Platform.operatingSystem) {
  //   case 'linux':
  //   case 'macos':
  //     return Platform.environment['HOME'] ?? "";
  //   case 'windows':
  //     return Platform.environment['USERPROFILE'] ?? "";
  //   case 'android':
  //     return '/storage/sdcard0';
  //   case 'ios':
  //     return Directory.current.path;
  //   default:
  //     return "";
  // }
}

String lookupPath(String path) {
  var homePath = appHomeDirectory();
  if (path == "~") return homePath;

  return path.replaceFirst("~/", homePath);
}
