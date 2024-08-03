import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PageTransitionType {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
  fade,
  size,
}

//creates a transition when going to the specified page
CustomTransitionPage returnCustomTransitionPage({
  required Widget child,
  required BuildContext context,
  required PageTransitionType type,
  int durationMillis = 500,
}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: Duration(milliseconds: durationMillis),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Widget transition;
      switch (type) {
        case PageTransitionType.leftToRight:
          transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
          break;
        case PageTransitionType.rightToLeft:
          transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
          break;
        case PageTransitionType.topToBottom:
          transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
          break;
        case PageTransitionType.bottomToTop:
          transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
          break;
        case PageTransitionType.fade:
          transition = FadeTransition(
            opacity: animation,
            child: child,
          );
          break;
        case PageTransitionType.size:
          transition = SizeTransition(
            sizeFactor: animation,
            child: child,
          );
          break;
        default:
          transition = child;
      }
      return transition;
    },
  );
}
