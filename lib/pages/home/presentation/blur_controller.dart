import 'package:flutter/material.dart';

/// Simple global controller to toggle a blur overlay on HomeScreen
class HomeBlurController {
  /// Notifies listeners when blur should be shown on the Home screen
  static final ValueNotifier<bool> isBlurred = ValueNotifier<bool>(false);

  /// Helper to show a bottom sheet while enabling blur overlay.
  static Future<T?> showWithBlur<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    Color backgroundColor = Colors.transparent,
    bool enableDrag = true,
  }) async {
    isBlurred.value = true;
    try {
      final result = await showModalBottomSheet<T>(
        context: context,
        isScrollControlled: isScrollControlled,
        backgroundColor: backgroundColor,
        enableDrag: enableDrag,
        builder: builder,
      );
      return result;
    } finally {
      isBlurred.value = false;
    }
  }
}
