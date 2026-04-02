import 'package:flutter/services.dart';

class VoipBridge {
  static const _channel = MethodChannel('com.fennec/callkit');

  static void init({
    required void Function(Map<String, dynamic> data) onAccept,
    required void Function(Map<String, dynamic> data) onDecline,
  }) {
    _channel.setMethodCallHandler((call) async {
      final args = Map<String, dynamic>.from(call.arguments ?? {});
      if (call.method == 'accept') {
        onAccept(args);
      } else if (call.method == 'decline') {
        onDecline(args);
      }
    });
  }
}
