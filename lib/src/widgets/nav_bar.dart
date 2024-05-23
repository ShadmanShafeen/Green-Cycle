// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavBarState extends State<NavBar> {
  int cur_index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: cur_index,
        onTap: (index) {
          setState(() {
            cur_index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: "Games",
              icon: Icon(Icons.sports_esports),
              activeIcon: Icon(Icons.sports_esports , color: Colors.tealAccent,),
          ),
          BottomNavigationBarItem(
              label: "Levels",
              icon: Icon(Icons.route),
            ),
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
              label: "Community",
              icon: Icon(Icons.groups),
          ),
          BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person_outline),
          ),
        ]);
  }
}
