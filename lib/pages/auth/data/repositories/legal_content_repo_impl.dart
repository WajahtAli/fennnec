import 'package:fennac_app/pages/auth/data/datasources/legal_content_datasource.dart';
import 'package:fennac_app/pages/auth/data/model/legal_content_model.dart';
import 'package:fennac_app/pages/auth/domain/repositories/legal_content_repo.dart';

class LegalContentRepoImpl extends LegalContentRepo {
  final LegalContentDatasource _legalContentDatasource;

  LegalContentRepoImpl(this._legalContentDatasource);

  @override
  Future<LegalContentModel> fetchLegalContents({
    bool? termOfService,
    bool? privacyPolicy,
  }) async {
    return await _legalContentDatasource.fetchLegalContents(
      termOfService: termOfService,
      privacyPolicy: privacyPolicy,
    );
  }
}
