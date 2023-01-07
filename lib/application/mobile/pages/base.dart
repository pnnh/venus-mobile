import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream/application/mobile/route.dart';
import 'package:flutter/material.dart';

import 'emotion/emotion.dart';
import 'other.dart';

class MobilePage extends Page {
  final MobileRoutePath routePath;

  MobilePage(
    this.routePath,
  ) : super(name: routePath.uri.toString(), key: ValueKey(routePath));

  @override
  Route createRoute(BuildContext context) {
    return MobilePageRoute(
      (BuildContext context) {
        debugPrint("createRoute ${routePath.uri}");
        return Scaffold(
          body: WindowBorder(
              color: const Color(0xFF805306),
              width: 1,
              child: selectPage(routePath.uri)),
        );
      },
      settings: this,
    );
  }
}

Widget selectPage(Uri uri) {
  debugPrint("uri_path ${uri.path}");
  switch (uri.path) {
    case "/other":
      return const OtherPage();
    default:
      return const EmotionPage();
  }
}
