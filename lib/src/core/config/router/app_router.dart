import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:proker/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:proker/src/features/auth/presentation/pages/sign_in_page.dart';
import 'package:proker/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:proker/src/features/event/presentation/event_page.dart';
import 'package:proker/src/features/home/presentation/home_page.dart';
import 'package:proker/src/features/home/presentation/profile_page.dart';
import 'package:proker/src/features/home/presentation/splash_page.dart';
import 'package:proker/src/features/home/presentation/widgets/tab_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: TabRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: EventRoute.page),
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
      ];
}
