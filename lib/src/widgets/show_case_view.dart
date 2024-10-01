import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
  ShowCaseView(
      {super.key,
      required this.globalKey,
      required this.title,
      required this.description,
      required this.child,
      this.shapeBorder = const CircleBorder(),});

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Showcase(
        key: globalKey,
        title: title,
        description: description,
        targetShapeBorder: shapeBorder,
        tooltipBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        textColor: Theme.of(context).colorScheme.onPrimary,
        titleTextStyle: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
        descTextStyle: TextStyle(fontSize: 12 , color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)),
        child: child);
  }
}
