// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavBarState extends State<NavBar> {
  int curIndex = 1;

  @override
  Widget build(BuildContext context) {
    final currentPath =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    if (currentPath == '/games') {
      curIndex = 0;
    } else if (currentPath == '/home') {
      curIndex = 1;
    } else if (currentPath == '/level-tracking') {
      curIndex = 2;
    }
    print(currentPath);

    return BottomNavigationBar(
      currentIndex: curIndex,
      showUnselectedLabels: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: currentPath == "/home" ||
              currentPath == '/level-tracking' ||
              currentPath == '/games'
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      selectedFontSize: 15,
      selectedIconTheme: IconThemeData(size: 30),
      onTap: (index) {
        setState(() {
          curIndex = index;
          if (curIndex == 1) {
            context.go('/home');
          } else if (curIndex == 2) {
            context.go('/level-tracking');
          }
        });

        switch (index) {
          case 0:
            context.go('/games');
            break;
          case 1:
            context.go('/home');
            break;
          case 2:
            context.go('/level-tracking');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          label: "Games",
          icon: Icon(Icons.sports_esports),
        ),
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Levels",
          icon: Icon(Icons.route),
        ),
      ],
    );
  }
}
