import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:proker/gen/assets.gen.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';

@RoutePage()
class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        EventRoute(),
        HomeRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
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
          items: _buildBottomNavigationBarItems(tabsRouter),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      TabsRouter tabsRouter) {
    final items = [
      {'icon': Assets.icons.icHome, 'label': 'Home'},
      {'icon': Assets.icons.icEvent, 'label': 'Event'},
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
