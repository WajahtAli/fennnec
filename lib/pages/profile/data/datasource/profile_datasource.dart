import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';

abstract class ProfileDatasource {
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

class ProfileDatasourceImpl extends ProfileDatasource {
  final ApiHelper apiHelper;

  ProfileDatasourceImpl(this.apiHelper);

  @override
  Future<dynamic> requestContactChange({String? email, String? phone}) async {
    final body = <String, dynamic>{};
    if (email != null && email.trim().isNotEmpty) {
      body['email'] = email.trim();
    }
    if (phone != null && phone.trim().isNotEmpty) {
      body['phone'] = phone.trim();
    }

    final response = await apiHelper.post(
      AppConstants.requestContactChange,
      requiresAuth: true,
      body: body,
    );

    return response;
  }

  @override
  Future<dynamic> verifyEmailOrPhoneOtp({
    required String requestId,
    required String verificationCode,
  }) async {
    final body = {'requestId': requestId, 'verificationCode': verificationCode};

    final response = await apiHelper.post(
      AppConstants.verifyContactChange,
      requiresAuth: true,
      body: body,
    );

    return response;
  }

  @override
  Future<dynamic> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final body = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };

    final response = await apiHelper.post(
      AppConstants.changePassword,
      requiresAuth: true,
      body: body,
    );

    return response;
  }
}
