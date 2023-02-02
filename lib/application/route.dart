
import 'package:dream/application/desktop/pages/emotion/emotion.dart';
import 'package:dream/application/desktop/pages/other.dart';
import 'package:dream/application/web/pages/admin/main.dart';
import 'package:dream/application/web/pages/random.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'mobile/pages/home.dart';
import 'mobile/pages/pictures.dart';



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
        GoRoute(
          path: 'random',
          builder: (BuildContext context, GoRouterState state) {
            return RandomPage( );
          },
        ),
        GoRoute(
          path: 'admin/main',
          builder: (BuildContext context, GoRouterState state) {
            return AdminMainPage( );
          },
        ),
        GoRoute(
          path: 'desktop/other',
          builder: (BuildContext context, GoRouterState state) {
            return OtherPage( );
          },
        ),
        GoRoute(
          path: 'desktop/emotion',
          builder: (BuildContext context, GoRouterState state) {
            return EmotionPage( );
          },
        ),
      ],
    ),
  ],
);
