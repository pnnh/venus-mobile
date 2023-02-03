import 'dart:io' show Platform;
import 'package:dream/application/pages/admin/main.dart';
import 'package:dream/application/pages/home/home.dart';
import 'package:dream/application/pages/pictures/pictures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter globalRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'pictures/:pk',
          builder: (BuildContext context, GoRouterState state) {
            return MPicturesPage(folderPk: state.params['pk'] as String);
          },
        ),
        GoRoute(
          path: 'admin/main',
          builder: (BuildContext context, GoRouterState state) {
            return AdminMainPage();
          },
        ),
        GoRoute(
          path: 'desktop/emotion',
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
        ),
      ],
    ),
  ],
);
