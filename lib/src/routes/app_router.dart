import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/weather_page.dart';
import '../presentation/pages/weather_detail_page.dart';
import 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home.path,
        builder: (BuildContext context, GoRouterState state) {
          return const WeatherPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.details.path,
            builder: (BuildContext context, GoRouterState state) {
              return const WeatherDetailPage();
            },
          ),
        ],
      ),
    ],
  );
}
