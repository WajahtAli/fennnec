import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:fennac_app/pages/auth/domain/repositories/login_repo.dart';

class LoginUsecase {
  final LoginRepo _loginRepo;

  LoginUsecase(this._loginRepo);

  Future<LoginModel> login({
    final String? emailOrPhone,
    final String? password,
  }) async {
    return await _loginRepo.login(
      emailOrPhone: emailOrPhone,
      password: password,
    );
  }

  Future<LoginModel> loginUserByGoogle({required String accessToken}) async {
    return await _loginRepo.loginUserByGoogle(accessToken: accessToken);
  }

  Future<LoginModel> loginUserByApple({
    required String firebaseUserId,
    double? latitude,
    double? longitude,
  }) async {
    return await _loginRepo.loginUserByApple(
      firebaseUserId: firebaseUserId,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<dynamic> requestPasswordReset({
    required String method,
    required String email,
  }) async {
    return await _loginRepo.requestPasswordReset(method: method, email: email);
  }

  Future<dynamic> verifyResetCode({
    required String method,
    required String email,
    required String resetCode,
  }) async {
    return await _loginRepo.verifyResetCode(
      method: method,
      email: email,
      resetCode: resetCode,
    );
  }

  Future<dynamic> resetPassword({
    required String method,
    required String email,
    required String resetCode,
    required String newPassword,
  }) async {
    return await _loginRepo.resetPassword(
      method: method,
      email: email,
      resetCode: resetCode,
      newPassword: newPassword,
    );
  }

  Future<dynamic> logout() async {
    return await _loginRepo.logout();
  }

  Future<LoginModel> refreshToken({required String refreshToken}) async {
    return await _loginRepo.refreshToken(refreshToken: refreshToken);
  }

  Future<dynamic> checkToken() async {
    return await _loginRepo.checkToken();
  }
}
