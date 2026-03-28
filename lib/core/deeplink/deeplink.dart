import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/extensions/route_guard.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';

import '../../app/app.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription? _sub;

  bool handledInitialLink = false;

  Future<void> init() async {
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      handledInitialLink = true;
      await _handleUri(initialUri);
    }

    _sub = _appLinks.uriLinkStream.listen((uri) async {
      if (uri.pathSegments.isNotEmpty) await _handleUri(uri);
    });
  }

  Future<void> _handleUri(Uri uri) async {
    final segments = uri.pathSegments;
    if (segments.isEmpty) return;

    final router = AutoRouter.of(navigatorKey.currentContext!);

    switch (segments.first) {
      case "likes":
        final id = int.tryParse(segments[1]);
        if (id == null) return;
        router.pushGuarded(HomeRoute(idFromDeepLink: id), requiresAuth: true);
        break;
    }
  }

  void dispose() => _sub?.cancel();
}
