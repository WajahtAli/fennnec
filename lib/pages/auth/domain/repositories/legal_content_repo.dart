import 'package:fennac_app/pages/auth/data/model/legal_content_model.dart';

abstract class LegalContentRepo {
  Future<LegalContentModel> fetchLegalContents({required bool termOfService});
}
