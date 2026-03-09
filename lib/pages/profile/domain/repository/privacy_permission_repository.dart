import 'package:fennac_app/pages/profile/data/models/privacy_permission_model.dart';

abstract class PrivacyPermissionRepository {
  Future<PrivacyPermissionModel> fetchPrivacyPermission();
  Future<PrivacyPermissionModel> updatePrivacyPermission({
    required PrivacyPermissionModel privacyPermissionModel,
  });
}
