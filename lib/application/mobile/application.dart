import 'package:dream/application/mobile/route.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
    return FluentApp.router(
      title: 'Mobile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          accentColor: Colors.blue,
          iconTheme: const IconThemeData(size: 24)),
      darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          accentColor: Colors.blue,
          iconTheme: const IconThemeData(size: 24)),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      color: Colors.white,
    );
  }
}

Future<Widget> initMobileApp() async {
  return const MobileApplication();
}
