import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:proker/presentation/home/home_page.dart';
import 'package:proker/presentation/home/splash_page.dart';
import 'package:proker/presentation/widgets/tab_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.custom(
      transitionsBuilder: TransitionsBuilders.noTransition);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/",
          page: TabRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: HomeRoute.page),
          ],
        ),
        AutoRoute(page: SplashRoute.page, initial: true),
      ];
}
