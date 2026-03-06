import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';

abstract class FaqsDatasource {
  Future<dynamic> fetchFaqs();
}

class FaqsDatasourceImpl extends FaqsDatasource {
  final ApiHelper apiHelper;

  FaqsDatasourceImpl(this.apiHelper);

  @override
  Future<dynamic> fetchFaqs() async {
    final response = await apiHelper.get(
      AppConstants.fetchFaqs,
      requiresAuth: true,
    );

    return response;
  }
}
