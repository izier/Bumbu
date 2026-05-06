import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../widgets/floating_nav_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(child: navigationShell),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingNavBar(
              currentIndex: navigationShell.currentIndex,
              onTap: _onTap,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.house),
                  activeIcon: const Icon(CupertinoIcons.house_fill),
                  label: t.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.archivebox),
                  activeIcon: const Icon(CupertinoIcons.archivebox_fill),
                  label: t.kitchen,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.rectangle_stack),
                  activeIcon: const Icon(CupertinoIcons.rectangle_stack_fill),
                  label: t.activity,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.chat_bubble),
                  activeIcon: const Icon(CupertinoIcons.chat_bubble_fill),
                  label: t.chat,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.person),
                  activeIcon: const Icon(CupertinoIcons.person_fill),
                  label: t.profile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
