import 'package:dream/application/desktop/pages/base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DesktopPageRoute extends MaterialPageRoute {
  DesktopPageRoute(WidgetBuilder builder, {RouteSettings? settings})
      : super(settings: settings, builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class DesktopRoutePath {
  late Uri uri;

  DesktopRoutePath(String location) {
    uri = Uri.parse(location);
  }

  DesktopRoutePath.home() : this("/");

  DesktopRoutePath.calendar() : this("/calendar");

  DesktopRoutePath.other() : this("/other");
}

class DesktopRouteInformationParser
    extends RouteInformationParser<DesktopRoutePath> {
  @override
  Future<DesktopRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    debugPrint('BookRouteInformationParser ${routeInformation.location}');
    return routeInformation.location != null
        ? DesktopRoutePath(routeInformation.location!)
        : DesktopRoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(DesktopRoutePath configuration) {
    return RouteInformation(location: configuration.uri.toString());
  }
}

class DesktopRouterDelegate extends RouterDelegate<DesktopRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<DesktopRoutePath> {
  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _stack = <DesktopRoutePath>[DesktopRoutePath.home()];
  int _currentIndex = 0;

  List<String> get stack => List.unmodifiable(_stack);

  DesktopRouterDelegate();

  static DesktopRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is DesktopRouterDelegate, 'Delegate type must match');
    return delegate as DesktopRouterDelegate;
  }

  @override
  DesktopRoutePath get currentConfiguration => _stack[_currentIndex];

  bool isFirst() {
    return _currentIndex == 0;
  }

  bool isLast() {
    return _currentIndex == _stack.length - 1;
  }

  void go(String location) {
    var newRoute = DesktopRoutePath(location);
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
  Future<void> setInitialRoutePath(DesktopRoutePath configuration) {
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(DesktopRoutePath configuration) async {
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
        pages.add(DesktopPage(_stack[i]));
      }
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      //pages: [MyPage(_stack[_currentIndex])],
      onPopPage: _onPopPage,
    );
  }
}
