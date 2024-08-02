import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/home/home_page.dart';

class ActionCard extends StatelessWidget {
  const ActionCard(
      {super.key,
      required this.label,
      required this.animatedIcon,
      required this.path});
  final Widget animatedIcon;
  final String label;
  final String path;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (path == "/home/locate-map") {
          showLocationPermission(context);
        } else {
          context.go(path);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              inset: true,
              blurRadius: 5,
              offset: const Offset(-1, -1),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            BoxShadow(
              inset: true,
              blurRadius: 5,
              offset: const Offset(3, 3),
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                animatedIcon,
                const SizedBox(height: 5),
                Text(
                  label,
                  textScaler: const TextScaler.linear(1.00),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
