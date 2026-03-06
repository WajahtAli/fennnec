import '../../domain/repository/faqs_repository.dart';
import '../datasource/faqs_datasource.dart';

class FaqsRepositoryImpl extends FaqsRepository {
  final FaqsDatasource _datasource;

  FaqsRepositoryImpl(this._datasource);

  @override
  Future<dynamic> fetchFaqs() async {
    return await _datasource.fetchFaqs();
  }
}
