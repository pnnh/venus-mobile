import 'dart:io' show Platform;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream/application/route.dart';
import 'package:flutter/material.dart';


class MobileApplication extends StatefulWidget {
  const MobileApplication({Key? key}) : super(key: key);

  @override
  State<MobileApplication> createState() => _MobileApplicationState();
}

class _MobileApplicationState extends State<MobileApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mobile App',
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
  return const MobileApplication();
}


Future<Widget> initApp() async {
  if (Platform.isIOS || Platform.isAndroid) {
    return MobileApplication();
  } else {
    return initDesktopApp();
  }
}
