// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:math';
import 'package:flutter/material.dart';

class LevelContainer extends StatefulWidget {
  LevelContainer(
      {super.key,
      required this.size,
      required this.level,
      required this.levelReached, required this.displayBottomSheet});

  final double size;
  final int level;
  final Future Function(BuildContext) displayBottomSheet;
  bool levelReached;

  @override
  State<LevelContainer> createState() => _LevelContainerState();
}

class _LevelContainerState extends State<LevelContainer> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HexagonClipper(),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // widget.levelReached = !widget.levelReached;
            widget.displayBottomSheet(context);
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          color: widget.levelReached
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          height: widget.size,
          width: widget.size,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.level.toString(),
                style: TextStyle(
                    color: widget.levelReached
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w900),
                textScaler: const TextScaler.linear(2.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final double width = size.width;
    final double height = size.height;
    final double xCenter = width / 2;
    final double yCenter = height / 2;
    final double radius = width / 2;

    for (int i = 0; i < 6; i++) {
      double angle = (i * 60.0) * (3.141592653589793 / 180.0);
      double x = xCenter + radius * cos(angle);
      double y = yCenter + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
