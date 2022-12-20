import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream/application/desktop/pages/calendar.dart';
import 'package:dream/application/desktop/route.dart';
import 'package:flutter/material.dart';

import 'emotion/emotion.dart';
import 'other.dart';

class DesktopPage extends Page {
  final DesktopRoutePath routePath;

  DesktopPage(
    this.routePath,
  ) : super(name: routePath.uri.toString(), key: ValueKey(routePath));

  @override
  Route createRoute(BuildContext context) {
    return DesktopPageRoute(
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
    case "/calendar":
      return const CalendarPage();
    case "/other":
      return const OtherPage();
    default:
      //return const HomePage();
      // todo 临时为了方便测试表情页面目的
      return const EmotionPage();
  }
}
