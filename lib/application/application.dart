import 'dart:io' show Platform;

import 'package:dream/application/desktop/application.dart';
import 'package:dream/application/mobile/application.dart';
import 'package:flutter/material.dart';

Future<Widget> initApp() async {
  if (Platform.isIOS || Platform.isAndroid) {
    return initMobileApp();
  } else {
    return initDesktopApp();
  }
}
