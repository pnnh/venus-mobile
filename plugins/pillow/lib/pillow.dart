import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pillow/pillow_web.dart';

class Pillow {
  static const MethodChannel _channel = MethodChannel('pillow');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Size> windowSize() async {
    final Size size = await _channel.invokeMethod('windowSize');
    return size;
  }

  static Future<String> randomString(
      {int length = 16,
      bool hasNumber = true,
      bool hasLetter = true,
      bool hasUppercaseLetter = true,
      bool hasSymbol = false}) async {
    final String version = await _channel.invokeMethod('randomString');
    return version;
  }

  static Future<String> getFontName() async {
    final String version = await _channel.invokeMethod('getFontName');
    return version;
  }

  static void openUrl(Uri url) {
    if (kIsWeb) {
      PillowWeb.openUrl(url);
      return;
    }
    throw UnimplementedError();
  }

  // static Future<String> initPlugin({String resUrl = ""}) async {
  //   return await _channel.invokeMethod('initPlugin', {"resUrl": resUrl});
  // }
}
