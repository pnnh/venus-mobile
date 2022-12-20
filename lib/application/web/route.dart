import 'dart:math';

import 'package:dream/application/web/pages/home/home.dart';
import 'package:dream/application/web/pages/random.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'pages/admin/main.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute(WidgetBuilder builder, {RouteSettings? settings})
      : super(settings: settings, builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class WebRoutePath {
  late Uri uri;
  static const homePath = "/";
  static const accountLoginPath = "/login";
  static const articleCreatePath = "/article/create";
  static const articleReadPath = "/article/read";
  static const emotionPath = "/emotion";
  static const resourcesPath = "/resources";

  WebRoutePath(String location) {
    uri = Uri.parse(location);
  }

  WebRoutePath.home() : this(homePath);

  WebRoutePath.login() : this(accountLoginPath);

  WebRoutePath.articleCreate() : this(articleCreatePath);
}

class WebRouteInformationParser extends RouteInformationParser<WebRoutePath> {
  @override
  Future<WebRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    debugPrint('BookRouteInformationParser ${routeInformation.location}');
    return routeInformation.location != null
        ? WebRoutePath(routeInformation.location!)
        : WebRoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(WebRoutePath configuration) {
    return RouteInformation(location: configuration.uri.toString());
  }
}

class WebRouterDelegate extends RouterDelegate<WebRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WebRoutePath> {
  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _stack = <WebRoutePath>[WebRoutePath.home()];
  int _currentIndex = 0;

  List<String> get stack => List.unmodifiable(_stack);

  WebRouterDelegate();

  static WebRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is WebRouterDelegate, 'Delegate type must match');
    return delegate as WebRouterDelegate;
  }

  @override
  WebRoutePath get currentConfiguration {
    debugPrint("currentConfiguration $_currentIndex");
    return _stack.last;
  }

  void go(String location) {
    debugPrint("go $location $_currentIndex");
    var newRoute = WebRoutePath(location);

    _stack.add(newRoute);
    _currentIndex++;
    notifyListeners();
  }

  @override
  Future<void> setInitialRoutePath(WebRoutePath configuration) {
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(WebRoutePath configuration) async {
    debugPrint('setNewRoutePath ${configuration.uri}');
    _stack
      ..clear()
      ..add(configuration);
    return SynchronousFuture<void>(null);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    debugPrint('_onPopPage ${route.settings}');
    if (_stack.length > 1) {
      _stack.removeLast();
      notifyListeners();
    }
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    List<Page<dynamic>> pages = [];
    for (var i = 0; i < _stack.length; i++) {
      if (i <= _currentIndex) {
        pages.add(WebPage(_stack[i]));
      }
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: _onPopPage,
    );
  }
}

class WebPage extends Page {
  final WebRoutePath routePath;

  WebPage(
    this.routePath,
  ) : super(name: routePath.uri.toString(), key: ValueKey(routePath));

  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      (BuildContext context) {
        debugPrint("createRoute ${routePath.uri}");
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            Size screenSize = MediaQuery.of(context).size;
            print("screenSize $screenSize");

            return ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  height: max(512, constraints.maxHeight)),
              child: Scaffold(
                // body: SingleChildScrollView(
                //     physics: const ClampingScrollPhysics(),
                //     child: Container(
                //       child: selectPage(routePath.uri),
                //     )),
                body: selectPage(routePath.uri),
                backgroundColor: const Color(0xffFAFAFA),
              ), // your column
            );
          },
        );
      },
      settings: this,
    );
  }
}

Widget selectPage(Uri uri) {
  debugPrint("uri_path ${uri.path}");
  switch (uri.path) {
    case "/random":
      return const RandomPage();
    case "/admin/main":
      return const AdminMainPage();
    default:
      return HomePage();
  }
}
