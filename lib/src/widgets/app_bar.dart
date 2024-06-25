// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/widgets/coins_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    final String currentPath =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    Text appBarTitle = Text('');
    if (currentPath == '/' ||
        currentPath == '/level-tracking' ||
        currentPath == '/games') {
      appBarTitle = Text('GreenCycle' , style: TextStyle(letterSpacing: 3),);
    } else if (currentPath == '/voucher-redemption') {
      appBarTitle = Text('Your Vouchers' , style: TextStyle(letterSpacing: 0),);
    }

    return AppBar(
      leading: currentPath == "/" ||
              currentPath == '/level-tracking' ||
              currentPath == '/games'
          ? IconButton(
              icon: Icon(
                Icons.compost,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {},
            )
          : BackButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () => context.pop(),
            ),
      title: appBarTitle,
      centerTitle: true,
      titleSpacing: 0,
      actions:  [ currentPath == '/' ||
        currentPath == '/level-tracking' ||
        currentPath == '/games' ?
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {},
        ) : SizedBox(),
        currentPath == '/' ||
        currentPath == '/level-tracking' ||
        currentPath == '/games' ? IconButton(
          icon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {},
        ) : SizedBox()
      ],
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
