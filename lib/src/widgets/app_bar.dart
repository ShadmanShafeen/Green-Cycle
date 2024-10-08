import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, isTransparent = false});
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
                onPressed: () {
                  context.go("/home/notification");
                },
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
