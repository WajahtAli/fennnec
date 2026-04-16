import 'dart:convert';
import 'dart:developer' as dev;
import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/pages/auth/data/model/login_model.dart';

abstract class LoginDatasource {
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

class LoginDatasourceImpl extends LoginDatasource {
  final ApiHelper apiHelper;

  LoginDatasourceImpl(this.apiHelper);

  @override
  Future<LoginModel> login({
    final String? emailOrPhone,
    final String? password,
  }) async {
    final data = await apiHelper.post(
      AppConstants.login,
      requiresAuth: false,
      isLogin: true,
      body: {"email": emailOrPhone, "password": password},
    );

    dev.log(
      '📥 Raw Login Response: ${jsonEncode(data)}',
      name: 'LoginDatasource',
    );

    // Check if response is error (when isLogin=true, 400 returns raw response)
    if (data['success'] == false) {
      dev.log(
        '🔴 Login Error - isVerified: ${data['isVerified']}, message: ${data['message']}',
        name: 'LoginDatasource',
      );
      throw LoginException(
        message: data['message'] ?? 'Login failed',
        isVerified: data['isVerified'],
      );
    }

    return LoginModel.fromJson(data);
  }

  @override
  Future<LoginModel> getProfile({required String userId}) async {
    final response = await apiHelper.get(
      AppConstants.getProfile,
      queryParameters: {'userId': userId},
      requiresAuth: true,
    );

    dev.log(
      '📥 Raw Get Profile Response: ${jsonEncode(response)}',
      name: 'LoginDatasource',
    );

    return LoginModel.fromJson(Map<String, dynamic>.from(response));
  }

  @override
  Future<LoginModel> loginUserByGoogle({required String accessToken}) async {
    final body = {
      "idToken": accessToken,
      // "latitude": 40.7128,
      // "longitude": -74.0060,
    };
    dev.log(
      '📤 Google login body: ${jsonEncode(body)}',
      name: 'LoginDatasource',
    );

    print('📤 Google login body: ${jsonEncode(body)}');

    final response = await apiHelper.post(
      AppConstants.loginGoogle,
      body: body,
      requiresAuth: false,
    );
    return LoginModel.fromJson(response);
  }

  @override
  Future<LoginModel> loginUserByApple({
    required String firebaseUserId,
    double? latitude,
    double? longitude,
  }) async {
    final body = {
      "firebaseUserId": firebaseUserId,
      if (latitude != null) "latitude": latitude,
      if (longitude != null) "longitude": longitude,
    };
    dev.log(
      '📤 Apple login body: ${jsonEncode(body)}',
      name: 'LoginDatasource',
    );

    final response = await apiHelper.post(
      AppConstants.loginApple,
      body: body,
      requiresAuth: false,
    );
    return LoginModel.fromJson(response);
  }

  @override
  Future<dynamic> requestPasswordReset({
    required String method,
    required String email,
  }) async {
    final body = {"method": method, "email": email};

    dev.log(
      '📤 Request password reset body: ${jsonEncode(body)}',
      name: 'LoginDatasource',
    );

    return await apiHelper.post(
      AppConstants.reqPasswordReset,
      body: body,
      requiresAuth: false,
    );
  }

  @override
  Future<dynamic> verifyResetCode({
    required String method,
    required String email,
    required String resetCode,
  }) async {
    final body = {
      "method": method,
      "email": "wajahtali55@gmail.com",
      "resetCode": resetCode,
    };

    dev.log(
      '📤 Verify reset code body: ${jsonEncode(body)}',
      name: 'LoginDatasource',
    );

    return await apiHelper.post(
      AppConstants.verifyResetCode,
      body: body,
      requiresAuth: false,
    );
  }

  @override
  Future<dynamic> resetPassword({
    required String method,
    required String email,
    required String resetCode,
    required String newPassword,
  }) async {
    final body = {
      "method": method,
      "email": email,
      "resetCode": resetCode,
      "newPassword": newPassword,
    };

    dev.log(
      '📤 Reset password body: ${jsonEncode(body)}',
      name: 'LoginDatasource',
    );

    return await apiHelper.post(
      AppConstants.resetPassword,
      body: body,
      requiresAuth: false,
    );
  }

  @override
  Future<dynamic> logout() async {
    final response = await apiHelper.post(
      AppConstants.logout,
      requiresAuth: true,
      isRefreshToken: true,
    );
    return response;
  }

  @override
  Future<dynamic> deleteAccount() async {
    final response = await apiHelper.delete(
      AppConstants.deleteAccount,
      requiresAuth: true,
    );
    return response;
  }

  @override
  Future<LoginModel> refreshToken({required String refreshToken}) async {
    final body = {"refresh_token": refreshToken};

    dev.log(
      '📤 Refresh token body: ${jsonEncode(body)}',
      name: 'LoginDatasource',
    );

    final response = await apiHelper.post(
      AppConstants.refreshToken,
      body: body,
      requiresAuth: true,
      isRefreshToken: true,
    );
    return LoginModel.fromJson(response);
  }

  @override
  Future<dynamic> checkToken() async {
    dev.log('📤 Checking token validity', name: 'LoginDatasource');

    final response = await apiHelper.post(
      AppConstants.checkToken,
      body: {},
      requiresAuth: true,
    );
    return response;
  }
}

class LoginException implements Exception {
  final String message;
  final bool? isVerified;

  LoginException({required this.message, this.isVerified});

  @override
  String toString() => message;
}
