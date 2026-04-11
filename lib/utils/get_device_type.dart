import 'dart:io';
import 'package:flutter/foundation.dart';

Future<String> getDeviceType() async {
  if (kIsWeb) {
    return 'web';
  } else if (Platform.isAndroid) {
    return 'android';
  } else if (Platform.isIOS) {
    return 'ios';
  } else if (Platform.isWindows) {
    return 'windows';
  } else if (Platform.isMacOS) {
    return 'macos';
  } else if (Platform.isLinux) {
    return 'linux';
  } else {
    return 'unknown';
  }
}
