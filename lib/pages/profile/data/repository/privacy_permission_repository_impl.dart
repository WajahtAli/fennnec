import 'package:fennac_app/pages/profile/data/datasource/privacy_permission_datasource.dart';
import 'package:fennac_app/pages/profile/data/models/privacy_permission_model.dart';
import 'package:fennac_app/pages/profile/domain/repository/privacy_permission_repository.dart';

class PrivacyPermissionRepositoryImpl extends PrivacyPermissionRepository {
  final PrivacyPermissionDatasource _datasource;

  PrivacyPermissionRepositoryImpl(this._datasource);

  @override
  Future<PrivacyPermissionModel> fetchPrivacyPermission() async {
    return await _datasource.fetchPrivacyPermission();
  }

  @override
  Future<PrivacyPermissionModel> updatePrivacyPermission({
    required PrivacyPermissionModel privacyPermissionModel,
  }) async {
    return await _datasource.updatePrivacyPermission(
      privacyPermissionModel: privacyPermissionModel,
    );
  }
}
