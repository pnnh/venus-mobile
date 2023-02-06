import 'dart:io' show Platform;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:venus/application/route.dart';
import 'package:venus/services/database.dart';
import 'package:flutter/material.dart';


class MainApplication extends StatefulWidget {
  const MainApplication({Key? key}) : super(key: key);

  @override
  State<MainApplication> createState() => _MainApplicationState();
}

class _MainApplicationState extends State<MainApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Venus Lighting',
      routerConfig: globalRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          iconTheme: const IconThemeData(size: 24)),
      darkTheme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black,
          iconTheme: const IconThemeData(size: 24)),
      // routerDelegate: globalRouter.routerDelegate,
      // routeInformationParser: globalRouter.routeInformationParser,
      color: Colors.white,
    );
  }
}


Future<Widget> initDesktopApp() async {
  doWhenWindowReady(() {
    appWindow.minSize = const Size(640, 480);
    appWindow.size = const Size(1280, 900);
    appWindow.maxSize = const Size(2560, 1920);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
  return const MainApplication();
}


Future<Widget> initApp() async {
  await DBHelper.initDatabase();
  if (Platform.isIOS || Platform.isAndroid) {
    return MainApplication();
  } else {
    return initDesktopApp();
  }
}
