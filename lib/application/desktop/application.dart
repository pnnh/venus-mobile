import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream/application/desktop/route.dart';
import 'package:dream/services/store/hive.dart';
import 'package:flutter/material.dart';

class DesktopApplication extends StatefulWidget {
  const DesktopApplication({Key? key}) : super(key: key);

  @override
  State<DesktopApplication> createState() => _DesktopApplicationState();
}

class _DesktopApplicationState extends State<DesktopApplication> {
  final DesktopRouterDelegate _routerDelegate = DesktopRouterDelegate();
  final DesktopRouteInformationParser _routeInformationParser =
      DesktopRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

Future<Widget> initApp() async {
  await HiveStore.init();
  doWhenWindowReady(() {
    appWindow.minSize = const Size(640, 480);
    appWindow.size = const Size(1280, 900);
    appWindow.maxSize = const Size(2560, 1920);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
  return const DesktopApplication();
}
