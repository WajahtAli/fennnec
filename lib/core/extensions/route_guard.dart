import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/deeplink/auth_service.dart';
import 'package:fennac_app/core/di_container.dart';

import '../../helpers/shared_pref_helper.dart';
import '../../routes/routes_imports.gr.dart';

extension GuardedNavigation on StackRouter {
  void pushGuarded(PageRouteInfo route, {bool requiresAuth = true}) {
    if (requiresAuth &&
        !(Di().sl<SharedPreferencesHelper>().getAuthToken() != null)) {
      AuthService.instance.pendingDeepLink = () => push(route);
      push(const LoginRoute());
    } else {
      push(route);
    }
  }
}
