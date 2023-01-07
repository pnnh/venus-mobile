import 'package:dream/application/mobile/route.dart';
import 'package:flutter/material.dart';

class MobileApplication extends StatefulWidget {
  const MobileApplication({Key? key}) : super(key: key);

  @override
  State<MobileApplication> createState() => _MobileApplicationState();
}

class _MobileApplicationState extends State<MobileApplication> {
  final MobileRouterDelegate _routerDelegate = MobileRouterDelegate();
  final MobileRouteInformationParser _routeInformationParser =
      MobileRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mobile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

Future<Widget> initMobileApp() async {
  return const MobileApplication();
}
