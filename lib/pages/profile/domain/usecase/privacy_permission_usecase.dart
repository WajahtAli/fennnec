import 'package:fennac_app/pages/profile/data/models/privacy_permission_model.dart';
import 'package:fennac_app/pages/profile/domain/repository/privacy_permission_repository.dart';

class PrivacyPermissionUsecase {
  final PrivacyPermissionRepository _repository;

  PrivacyPermissionUsecase(this._repository);

  Future<PrivacyPermissionModel> fetchPrivacyPermission() async {
    return await _repository.fetchPrivacyPermission();
  }

  Future<PrivacyPermissionModel> updatePrivacyPermission({
    required PrivacyPermissionModel privacyPermissionModel,
  }) async {
    return await _repository.updatePrivacyPermission(
      privacyPermissionModel: privacyPermissionModel,
    );
  }
}
