import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'route.dart';

class WebApplication extends StatefulWidget {
  const WebApplication({Key? key}) : super(key: key);

  @override
  State<WebApplication> createState() => _WebApplicationState();
}

class _WebApplicationState extends State<WebApplication> {
  final WebRouterDelegate _routerDelegate = WebRouterDelegate();
  final WebRouteInformationParser _routeInformationParser =
      WebRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1400, 1200),
      builder: (context, child) {
        return MaterialApp.router(
          title: '网页应用',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            //fontFamily: "NotoSansSC", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                  //fontFamily: "NotoSansSC", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
                ),
          ),
          debugShowCheckedModeBanner: false,
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
        );
      },
    );
  }
}
