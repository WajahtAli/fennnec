import 'package:fennac_app/pages/auth/data/model/login_model.dart';

abstract class LoginRepo {
  Future<LoginModel> login({
    final String? emailOrPhone,
    final String? password,
  });
  Future<LoginModel> getProfile({required String userId});
  Future<LoginModel> loginUserByGoogle({required String accessToken});
  Future<LoginModel> loginUserByApple({
    required String firebaseUserId,
    double? latitude,
    double? longitude,
  });
  Future<dynamic> requestPasswordReset({
    required String method,
    required String email,
  });
  Future<dynamic> verifyResetCode({
    required String method,
    required String email,
    required String resetCode,
  });
  Future<dynamic> resetPassword({
    required String method,
    required String email,
    required String resetCode,
    required String newPassword,
  });
  Future<dynamic> logout();
  Future<dynamic> deleteAccount();
  Future<LoginModel> refreshToken({required String refreshToken});
  Future<dynamic> checkToken();
}
