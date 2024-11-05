import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proker/config/injection/injection.dart';
import 'package:proker/config/router/app_router.dart';
import 'package:proker/config/themes/app_theme.dart';
import 'package:proker/data/repositories/auth_repository_impl.dart';
import 'package:proker/presentation/bloc/auth/auth_bloc.dart';
import 'package:proker/presentation/bloc/auth/auth_event.dart';
import 'package:proker/presentation/bloc/auth/auth_state.dart';
import 'package:proker/utils/contants/app_constants.dart';

final _authRepository = getIt<AuthRepositoryImpl>();

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const App({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepository: _authRepository)..add(AppLoaded()),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final appRouter = AppRouter(context, navigatorKey);
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) async {
                  await Future.delayed(
                      const Duration(seconds: 1, milliseconds: 500));
                  if (state is Unauthenticated) {
                    appRouter.router.refresh();
                  }
                },
              ),
            ],
            child: MaterialApp.router(
              title: AppConstants.appTitle,
              theme: AppTheme.light,
              routerConfig: appRouter.router,
              builder: (context, child) {
                // FlutterBackgroundService().on('changeAuthState').listen((event) {
                //   if (event != null) {
                //     final isAuthenticated = event['is_authenticated'] as String;
                //     if (isAuthenticated == 'false') {
                //       context.read<AuthBloc>().add(LoggedOut());
                //     }
                //   }
                // });

                // return Stack(
                //   children: [
                //     child!,
                //     ZegoUIKitPrebuiltLiveStreamingMiniOverlayPage(
                //       contextQuery: () {
                //         return navigatorKey.currentState!.context;
                //       },
                //     ),
                //   ],
                // );
                return child!;
              },
            ),
          );
        },
      ),
    );
  }
}
