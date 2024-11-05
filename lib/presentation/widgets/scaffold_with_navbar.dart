import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proker/config/themes/app_colors.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(
      {super.key,
      required this.navigationShell,
      this.showBottomNavigationBar = true});

  final StatefulNavigationShell navigationShell;
  final bool showBottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: showBottomNavigationBar
          ? BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined, // Default icon for unselected state
                    color: AppColors.inputFocus,
                  ),
                  activeIcon: Icon(
                    Icons.home, // Icon for the selected state
                    color: AppColors.primary,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.event_outlined, // Default icon for unselected state
                      color: AppColors.inputFocus,
                    ),
                    label: 'Event',
                    activeIcon: Icon(
                      Icons.event, // Icon for the selected state
                      color: AppColors.primary,
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.feed_outlined, // Default icon for unselected state
                      color: AppColors.inputFocus,
                    ),
                    label: 'Feed',
                    activeIcon: Icon(
                      Icons.feed, // Icon for the selected state
                      color: AppColors.primary,
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outline, // Default icon for unselected state
                      color: AppColors.inputFocus,
                    ),
                    label: 'Profile',
                    activeIcon: Icon(
                      Icons.person, // Icon for the selected state
                      color: AppColors.primary,
                    )),
              ],
              backgroundColor: Colors.white,
              unselectedItemColor: AppColors.inputFocus,
              type: BottomNavigationBarType.fixed,
              onTap: _onTap,
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.normal,
              ),
              selectedItemColor: AppColors.primary,
              selectedFontSize: 12,
              selectedLabelStyle: const TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800,
              ),
            )
          : null,
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
