import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/src/core/blocs/theme/theme_bloc.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_theme.dart';
import 'package:proker/src/core/constants/app_constants.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:proker/src/features/home/presentation/bloc/home_cubit.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final _appRouter = AppRouter();

  App({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<HomeCubit>()..fetchDataFromFirestore(),
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (_, themeState) {
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
                    theme: AppTheme.data(themeState.isDarkMode),
                    routerConfig: _appRouter.config(),
                    builder: (context, child) {
                      return Stack(
                        children: [
                          child!,
                          ZegoUIKitPrebuiltLiveStreamingMiniOverlayPage(
                            contextQuery: () {
                              return navigatorKey.currentState!.context;
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
