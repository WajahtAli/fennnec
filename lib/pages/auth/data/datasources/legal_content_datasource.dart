import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/pages/auth/data/model/legal_content_model.dart';

abstract class LegalContentDatasource {
  Future<LegalContentModel> fetchLegalContents({
    bool? termOfService,
    bool? privacyPolicy,
  });
}

class LegalContentDatasourceImpl extends LegalContentDatasource {
  final ApiHelper apiHelper;

  LegalContentDatasourceImpl(this.apiHelper);

  @override
  Future<LegalContentModel> fetchLegalContents({
    bool? termOfService,
    bool? privacyPolicy,
  }) async {
    final response = await apiHelper.get(
      AppConstants.legalContents,
      queryParameters: {
        if (termOfService != null) 'termOfService': termOfService,
        if (privacyPolicy != null) 'privacyPolicy': privacyPolicy,
      },
      requiresAuth: true,
    );

    return LegalContentModel.fromJson(response);
  }
}
