import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../widgets/call_pip_overlay.dart';

class CallPipOverlayController {
  static OverlayEntry? _overlayEntry;

  static bool get isShowing => _overlayEntry != null;

  static void show() {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    hide();
    _overlayEntry = OverlayEntry(builder: (_) => const CallPipOverlay());
    overlay.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
