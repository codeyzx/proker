import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proker/gen/assets.gen.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';

@RoutePage()
class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    String userRole = '';

    if (authState is AuthAuthenticatedState) {
      userRole = authState.data.role ?? '';
      logger.i('userRole: $userRole');
    } else if (authState is AuthLogoutLoadingState) {
      context.router.replaceAll([const SignInRoute()]);
    }

    final routes = [
      const HomeRoute(),
      const EventRoute(),
      if (userRole == 'pengelola') const KelolaEventRoute(),
      const EventRoute(),
      const ProfileRoute(),
    ];

    return AutoTabsScaffold(
      routes: routes,
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex < routes.length
              ? tabsRouter.activeIndex
              : 0,
          onTap: (index) {
            if (index < routes.length) {
              tabsRouter.setActiveIndex(index);
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          items: _buildBottomNavigationBarItems(tabsRouter, userRole),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      TabsRouter tabsRouter, String userRole) {
    final items = [
      {'icon': Assets.icons.icHome, 'label': 'Home'},
      {'icon': Assets.icons.icEvent, 'label': 'Event'},
      if (userRole == 'pengelola')
        {'icon': Assets.icons.icSearch, 'label': 'Kelola Event'},
      {'icon': Assets.icons.icFeed, 'label': 'Feed'},
      {'icon': Assets.icons.icProfile, 'label': 'Profile'},
    ];

    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return BottomNavigationBarItem(
        icon: (item['icon'] as SvgGenImage).svg(
          width: 32,
          height: 32,
          colorFilter: ColorFilter.mode(
            tabsRouter.activeIndex == index ? AppColors.primary : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
        label: item['label'] as String?,
      );
    }).toList();
  }
}
