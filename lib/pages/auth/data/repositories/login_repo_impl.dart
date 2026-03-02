import 'package:fennac_app/pages/auth/data/datasources/login_datasource.dart';
import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:fennac_app/pages/auth/domain/repositories/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final LoginDatasource _loginDatasource;

  LoginRepoImpl(this._loginDatasource);

  @override
  Future<LoginModel> login({
    final String? emailOrPhone,
    final String? password,
  }) async {
    return await _loginDatasource.login(
      emailOrPhone: emailOrPhone,
      password: password,
    );
  }

  @override
  Future<LoginModel> loginUserByGoogle({required String accessToken}) async {
    return await _loginDatasource.loginUserByGoogle(accessToken: accessToken);
  }

  @override
  Future<LoginModel> loginUserByApple({
    required String firebaseUserId,
    double? latitude,
    double? longitude,
  }) async {
    return await _loginDatasource.loginUserByApple(
      firebaseUserId: firebaseUserId,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<dynamic> requestPasswordReset({
    required String method,
    required String email,
  }) async {
    return await _loginDatasource.requestPasswordReset(
      method: method,
      email: email,
    );
  }

  @override
  Future<dynamic> verifyResetCode({
    required String method,
    required String email,
    required String resetCode,
  }) async {
    return await _loginDatasource.verifyResetCode(
      method: method,
      email: email,
      resetCode: resetCode,
    );
  }

  @override
  Future<dynamic> resetPassword({
    required String method,
    required String email,
    required String resetCode,
    required String newPassword,
  }) async {
    return await _loginDatasource.resetPassword(
      method: method,
      email: email,
      resetCode: resetCode,
      newPassword: newPassword,
    );
  }

  @override
  Future<dynamic> logout() async {
    return await _loginDatasource.logout();
  }

  @override
  Future<LoginModel> refreshToken({required String refreshToken}) async {
    return await _loginDatasource.refreshToken(refreshToken: refreshToken);
  }

  @override
  Future<dynamic> checkToken() async {
    return await _loginDatasource.checkToken();
  }
}
