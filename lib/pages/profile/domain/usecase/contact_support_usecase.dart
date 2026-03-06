import '../repository/contact_support_repository.dart';

class ContactSupportUsecase {
  final ContactSupportRepository _repository;

  ContactSupportUsecase(this._repository);

  Future<dynamic> addContactSupport({
    required String subject,
    required String message,
  }) async {
    return await _repository.addContactSupport(
      subject: subject,
      message: message,
    );
  }
}
