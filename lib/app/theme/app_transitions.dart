import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTransitions {
  static Route<T> platformRouteBuilder<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    final platform = Theme.of(context).platform;
    final isCupertinoPlatform =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (isCupertinoPlatform) {
      return CupertinoPageRoute<T>(
        settings: page,
        fullscreenDialog: page.fullscreenDialog,
        title: page.routeData.title(context),
        builder: (_) => child,
      );
    }

    final routeType = page.routeData.type;
    final customType = routeType is CustomRouteType ? routeType : null;

    return PageRouteBuilder<T>(
      settings: page,
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder:
          customType?.transitionsBuilder ?? AppTransitions.noTransition,
      transitionDuration:
          customType?.duration ?? const Duration(milliseconds: 300),
      reverseTransitionDuration:
          customType?.reverseDuration ?? const Duration(milliseconds: 300),
      opaque: customType?.opaque ?? true,
      barrierDismissible: customType?.barrierDismissible ?? false,
      barrierColor: customType?.barrierColor,
      barrierLabel: customType?.barrierLabel,
    );
  }

  static Widget fade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  static Widget slideUp(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeInOut));

    return SlideTransition(position: animation.drive(tween), child: child);
  }

  static Widget slideRight(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeInOutCubic));

    return SlideTransition(position: animation.drive(tween), child: child);
  }

  static Widget noTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
