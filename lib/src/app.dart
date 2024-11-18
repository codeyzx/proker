import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/src/core/blocs/theme/theme_bloc.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_theme.dart';
import 'package:proker/src/core/constants/app_constants.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (_, current) =>
            current is AuthCheckSignInStatusSuccessState,
        listener: (_, state) {
          if (state is AuthCheckSignInStatusSuccessState) {
            context.replaceRoute(const HomeRoute());
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, state) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: ScreenUtil(
                options: const ScreenUtilOptions(
                  enable: true,
                  designSize: Size(390, 844),
                  fontFactorByWidth: 2.0,
                  fontFactorByHeight: 1.0,
                  flipSizeWhenLandscape: true,
                ),
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: AppConstants.appTitle,
                  theme: AppTheme.data(state.isDarkMode),
                  routerConfig: _appRouter.config(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
