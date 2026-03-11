import 'package:fennac_app/pages/auth/data/model/legal_content_model.dart';
import 'package:fennac_app/pages/auth/domain/repositories/legal_content_repo.dart';

class LegalContentUsecase {
  final LegalContentRepo _legalContentRepo;

  LegalContentUsecase(this._legalContentRepo);

  Future<LegalContentModel> fetchLegalContents({
    bool? termOfService,
    bool? privacyPolicy,
  }) async {
    return await _legalContentRepo.fetchLegalContents(
      termOfService: termOfService,
      privacyPolicy: privacyPolicy,
    );
  }
}
