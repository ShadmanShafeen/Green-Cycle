import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    final String currentPath =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    Text appBarTitle = const Text('');
    if (currentPath == '/home' ||
        currentPath == '/level-tracking' ||
        currentPath == '/games') {
      appBarTitle = const Text(
        'GreenCycle',
        style: TextStyle(letterSpacing: 3),
      );
    } else if (currentPath == '/home/voucher-redemption') {
      appBarTitle = const Text(
        'Your Vouchers',
        style: TextStyle(
          letterSpacing: 0,
        ),
      );
    }

    return AppBar(
      leading: currentPath == "/home" ||
              currentPath == '/level-tracking' ||
              currentPath == '/games'
          ? IconButton(
              icon: Icon(
                Icons.compost,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                context.go('/home');
              },
            )
          : BackButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () => context.pop(),
            ),
      title: appBarTitle,
      centerTitle: true,
      titleSpacing: 0,
      actions: [
        currentPath == '/home' ||
                currentPath == '/level-tracking' ||
                currentPath == '/games'
            ? IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {},
              )
            : const SizedBox(),
        currentPath == '/home' ||
                currentPath == '/level-tracking' ||
                currentPath == '/games'
            ? IconButton(
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  context.go('/home/profile');
                },
              )
            : const SizedBox()
      ],
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
