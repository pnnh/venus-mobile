import 'package:dream/application/mobile/pages/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pages/pictures.dart';

class MobilePageRoute extends MaterialPageRoute {
  MobilePageRoute(WidgetBuilder builder, {RouteSettings? settings})
      : super(settings: settings, builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class MobileRoutePath {
  late Uri uri;

  MobileRoutePath(String location) {
    uri = Uri.parse(location);
  }

  MobileRoutePath.home() : this("/");
}

class MobileRouteInformationParser
    extends RouteInformationParser<MobileRoutePath> {
  @override
  Future<MobileRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    debugPrint('BookRouteInformationParser ${routeInformation.location}');
    return routeInformation.location != null
        ? MobileRoutePath(routeInformation.location!)
        : MobileRoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(MobileRoutePath configuration) {
    return RouteInformation(location: configuration.uri.toString());
  }
}

class MobileRouterDelegate extends RouterDelegate<MobileRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MobileRoutePath> {
  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _stack = <MobileRoutePath>[MobileRoutePath.home()];
  int _currentIndex = 0;

  List<String> get stack => List.unmodifiable(_stack);

  MobileRouterDelegate();

  static MobileRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is MobileRouterDelegate, 'Delegate type must match');
    return delegate as MobileRouterDelegate;
  }

  @override
  MobileRoutePath get currentConfiguration => _stack[_currentIndex];

  bool isFirst() {
    return _currentIndex == 0;
  }

  bool isLast() {
    return _currentIndex == _stack.length - 1;
  }

  void go(String location) {
    var newRoute = MobileRoutePath(location);
    for (var i = _currentIndex + 1; i < _stack.length; i++) {
      _stack.removeAt(i);
    }
    _stack.add(newRoute);
    _currentIndex++;
    notifyListeners();
  }

  void back() {
    if (_stack.length > 1 && _currentIndex > 0) {
      _currentIndex--;
    }
    notifyListeners();
  }

  void forward() {
    if (_currentIndex < _stack.length - 1) {
      _currentIndex++;
    }
    notifyListeners();
  }

  @override
  Future<void> setInitialRoutePath(MobileRoutePath configuration) {
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(MobileRoutePath configuration) async {
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
        pages.add(MobilePage(_stack[i]));
      }
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: _onPopPage,
    );
  }
}

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
          backgroundColor: Colors.white,
          body: selectPage(routePath.uri),
        );
      },
      settings: this,
    );
  }
}

Widget selectPage(Uri uri) {
  debugPrint("uri_path ${uri.path}");
  switch (uri.path) {
    case "/pictures":
      return const MPicturesPage();
    default:
      return const MHomePage();
  }
}
