// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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
      child: SizedBox(
        width: 100,
        height: 100,
        child: Card(
          elevation: 5,
          color: Theme.of(context).colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Theme.of(context).colorScheme.surfaceBright,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  animatedIcon,
                  SizedBox(height: 5),
                  Text(
                    label,
                    textScaler: TextScaler.linear(1.00),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
