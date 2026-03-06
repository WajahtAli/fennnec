import '../../domain/repository/contact_support_repository.dart';
import '../datasource/contact_support_datasource.dart';

class ContactSupportRepositoryImpl extends ContactSupportRepository {
  final ContactSupportDatasource _datasource;

  ContactSupportRepositoryImpl(this._datasource);

  @override
  Future<dynamic> addContactSupport({
    required String subject,
    required String message,
  }) async {
    return await _datasource.addContactSupport(
      subject: subject,
      message: message,
    );
  }
}
