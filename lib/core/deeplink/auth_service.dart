import 'package:flutter/services.dart';

class AuthService {
  AuthService._privateConstructor();
  static final instance = AuthService._privateConstructor();

  VoidCallback? pendingDeepLink;

  void completePendingDeepLink() {
    if (pendingDeepLink != null) {
      pendingDeepLink!();
      pendingDeepLink = null;
    }
  }
}
