import 'package:permission_handler/permission_handler.dart';

/// Requests camera permission from the user.
///
/// Returns [true] if permission is granted, [false] otherwise.
/// If permission is permanently denied, opens the app settings.
Future<bool> requestCameraPermission() async {
  var status = await Permission.camera.status;

  if (status.isGranted) {
    return true;
  }

  if (status.isDenied) {
    final result = await Permission.camera.request();
    return result.isGranted;
  }

  // Permanently denied / restricted
  return false;
}

/// Requests microphone permission from the user.
///
/// Returns [true] if permission is granted, [false] otherwise.
/// If permission is permanently denied, opens the app settings.
Future<bool> requestMicrophonePermission() async {
  var status = await Permission.microphone.status;

  if (status.isDenied) {
    status = await Permission.microphone.request();
  }

  return status.isGranted;
}

/// Requests photo library permission from the user.
///
/// Returns [true] if permission is granted, [false] otherwise.
/// If permission is permanently denied, opens the app settings.
Future<bool> requestPhotoLibraryPermission() async {
  var status = await Permission.photos.status;

  if (status.isDenied) {
    status = await Permission.photos.request();
  }

  if (status.isLimited) {
    return true; // iOS limited access is acceptable
  }

  return status.isGranted;
}

/// Requests location permission from the user.
///
/// Returns [true] if permission is granted, [false] otherwise.
/// If permission is permanently denied, opens the app settings.
Future<bool> requestLocationPermission() async {
  var status = await Permission.location.status;

  if (status.isDenied) {
    status = await Permission.location.request();
  }

  if (status.isPermanentlyDenied) {
    openAppSettings();
    return false;
  }

  return status.isGranted;
}
