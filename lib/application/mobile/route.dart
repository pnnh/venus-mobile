import 'package:dream/application/mobile/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/pictures.dart';

final GoRouter globalRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MHomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'pictures/:pk',
          builder: (BuildContext context, GoRouterState state) {
            return MPicturesPage(folderPk: state.params['pk'] as String);
          },
        ),
      ],
    ),
  ],
);
