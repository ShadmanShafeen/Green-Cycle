import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessElement {
  ShowCaseView(super.widget, 
      {required this.globalKey,
      required this.title,
      required this.description,
      required this.child,
      required this.shapeBorder});

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;

  @override
  Widget build() {
    return Showcase(
        key: globalKey,
        title: title,
        description: description,
        targetShapeBorder: shapeBorder,
        child: child);
  }
}
