import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:go_router/go_router.dart'
    show
        GoRoute,
        GoRouter,
        NoTransitionPage,
        StatefulShellBranch,
        StatefulShellRoute;
import 'package:injectable/injectable.dart' show singleton;
import 'package:proker/config/themes/app_colors.dart';
import 'package:proker/presentation/bloc/auth/auth_bloc.dart';
import 'package:proker/presentation/bloc/auth/auth_state.dart';
import 'package:proker/presentation/home/home_page.dart';
import 'package:proker/presentation/home/splash_page.dart';
import 'package:proker/presentation/widgets/scaffold_with_navbar.dart';

@singleton
class AppRouter {
  late final GoRouter _router;
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouter(BuildContext context, this.navigatorKey) {
    _router = GoRouter(
      errorPageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Halaman tidak ditemukan'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    onPressed: () => GoRouter.of(context).go('/'),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(color: AppColors.textWhite),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      // initialLocation: '/',
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SplashPage(),
          ),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNavbar(
              navigationShell: navigationShell,
              showBottomNavigationBar: true,
              // role: context.read<AuthBloc>().state is Authenticated
              //     ? (context.read<AuthBloc>().state as Authenticated).role
              //     : '',
              // role: '',
            );
          },
          branches: [
            // Home Branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  ),
                ),
              ],
            ),

            // Home Branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  ),
                ),
              ],
            ),

            // Home Branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  ),
                ),
              ],
            ),

            // Home Branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
      // redirect: (context, state) {
      //   final authState = context.read<AuthBloc>().state;
      //   if (authState is AuthInitial) {
      //     return '/splash';
      //   }

      //   if (authState is! Authenticated) {
      //     if (state.matchedLocation != '/login') {
      //       return '/login';
      //     }
      //   } else {
      //     if (state.matchedLocation == '/login') {
      //       return '/';
      //     }
      //   }
      //   return null;
      // },
      refreshListenable: GoRouterRefreshStream(context.read<AuthBloc>().stream),
    );
  }

  GoRouter get router => _router;
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<AuthState> stream) {
    stream.listen((_) => notifyListeners());
  }
}
