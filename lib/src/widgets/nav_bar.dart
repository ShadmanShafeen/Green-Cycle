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
    final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    
    return BottomNavigationBar(
        currentIndex: curIndex,
        showUnselectedLabels: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: currentPath == "/" || currentPath == '/level-tracking' || currentPath == '/games' ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
        selectedFontSize: 15,
        selectedIconTheme: IconThemeData(size: 30),
        onTap: (index) {
          setState(() {
            curIndex = index;
            if (curIndex == 1) {
              context.go('/');
            } else if (curIndex == 2) {
              context.go('/level-tracking');
            }
          });
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

          // BottomNavigationBarItem(
          //     label: "Community",
          //     icon: Icon(Icons.groups),
          // ),
          // BottomNavigationBarItem(
          //     label: "Profile",
          //     icon: Icon(Icons.person_outline),
          // ),
        ]);
  }
}
