import 'package:dream/application/mobile/route.dart';
//import 'package:fluent_ui/fluent_ui.dart';
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

Future<Widget> initMobileApp() async {
  return const MobileApplication();
}
