abstract class ProfileRepository {
  Future<dynamic> requestContactChange({String? email, String? phone});
  Future<dynamic> verifyEmailOrPhoneOtp({
    required String requestId,
    required String verificationCode,
  });
  Future<dynamic> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
