abstract class ContactSupportRepository {
  Future<dynamic> addContactSupport({
    required String subject,
    required String message,
  });
}
