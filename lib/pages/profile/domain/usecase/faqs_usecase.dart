import '../repository/faqs_repository.dart';

class FaqsUsecase {
  final FaqsRepository _repository;

  FaqsUsecase(this._repository);

  Future<dynamic> fetchFaqs() async {
    return await _repository.fetchFaqs();
  }
}
