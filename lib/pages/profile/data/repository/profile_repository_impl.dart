import '../../domain/repository/profile_repository.dart';
import '../datasource/profile_datasource.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDatasource _datasource;

  ProfileRepositoryImpl(this._datasource);

  @override
  Future<dynamic> requestContactChange({String? email, String? phone}) async {
    return await _datasource.requestContactChange(email: email, phone: phone);
  }

  @override
  Future<dynamic> verifyEmailOrPhoneOtp({
    required String requestId,
    required String verificationCode,
  }) async {
    return await _datasource.verifyEmailOrPhoneOtp(
      requestId: requestId,
      verificationCode: verificationCode,
    );
  }

  @override
  Future<dynamic> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await _datasource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
