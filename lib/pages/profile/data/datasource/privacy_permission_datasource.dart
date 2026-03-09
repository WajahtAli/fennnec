import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/pages/profile/data/models/privacy_permission_model.dart';

abstract class PrivacyPermissionDatasource {
  Future<PrivacyPermissionModel> fetchPrivacyPermission();
  Future<PrivacyPermissionModel> updatePrivacyPermission({
    required PrivacyPermissionModel privacyPermissionModel,
  });
}

class PrivacyPermissionDatasourceImpl extends PrivacyPermissionDatasource {
  final ApiHelper apiHelper;

  PrivacyPermissionDatasourceImpl(this.apiHelper);

  @override
  Future<PrivacyPermissionModel> fetchPrivacyPermission() async {
    final response = await apiHelper.get(
      'privacy-permission',
      requiresAuth: true,
    );

    return PrivacyPermissionModel.fromJson(response);
  }

  @override
  Future<PrivacyPermissionModel> updatePrivacyPermission({
    required PrivacyPermissionModel privacyPermissionModel,
  }) async {
    final response = await apiHelper.put(
      'privacy-permission',
      requiresAuth: true,
      body: {
        'privacyPermissions':
            privacyPermissionModel.data?.privacyPermissions?.toJson() ?? {},
      },
    );

    return PrivacyPermissionModel.fromJson(response);
  }
}
