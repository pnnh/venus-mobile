import 'dart:async';
import 'dart:html';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js_util.dart';

/// A web implementation of the Pillow plugin.
class PillowWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'pillow',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = PillowWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
      case 'windowSize':
        return windowSize();
      case 'initPlugin':
        return initPlugin(call);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'pillow for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  Future<String> getPlatformVersion() {
    final version = window.navigator.userAgent;
    return Future.value(version);
  }

  Size windowSize() {
    var width = window.screen?.width ?? 1400;
    var height = window.screen?.height ?? 900;
    return Size(width.toDouble(), height.toDouble());
  }

  String initPlugin(MethodCall call) {
    // String resUrl = call.arguments != null ? call.arguments["resUrl"] : "";
    // debugPrint("arguments: $resUrl ${call.arguments}");
    //
    // document.head!.append(ScriptElement()
    //   ..src = resUrl
    //   ..type = 'module'
    //   ..defer = false);

    return "";
  }

  static void openUrl(Uri url) {
    window.location.href = url.toString();
  }
}
