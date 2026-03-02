import '../repository/profile_repository.dart';

class ProfileUsecase {
  final ProfileRepository _repository;

  ProfileUsecase(this._repository);

  Future<dynamic> requestContactChange({String? email, String? phone}) async {
    return await _repository.requestContactChange(email: email, phone: phone);
  }

  Future<dynamic> verifyEmailOrPhoneOtp({
    required String requestId,
    required String verificationCode,
  }) async {
    return await _repository.verifyEmailOrPhoneOtp(
      requestId: requestId,
      verificationCode: verificationCode,
    );
  }

  Future<dynamic> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
