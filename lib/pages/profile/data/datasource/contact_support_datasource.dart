import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';

abstract class ContactSupportDatasource {
  Future<dynamic> addContactSupport({
    required String subject,
    required String message,
  });
}

class ContactSupportDatasourceImpl extends ContactSupportDatasource {
  final ApiHelper apiHelper;

  ContactSupportDatasourceImpl(this.apiHelper);

  @override
  Future<dynamic> addContactSupport({
    required String subject,
    required String message,
  }) async {
    final body = {'subject': subject.trim(), 'message': message.trim()};

    final response = await apiHelper.post(
      AppConstants.contactSupport,
      requiresAuth: true,
      body: body,
    );

    return response;
  }
}
