import 'package:fast_contacts/fast_contacts.dart';

class SelectedMember {
  final String id; // Fennec API ID or normalized phone number
  final String displayName;
  final String? profileImageUrl;
  final String? phoneNumber;
  final String? email;
  final bool isFennecUser;
  final Contact? contact;
  final String? fennecId;

  SelectedMember({
    required this.id,
    required this.displayName,
    this.profileImageUrl,
    this.phoneNumber,
    this.email,
    this.isFennecUser = false,
    this.contact,
    this.fennecId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedMember &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
