import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/create_group/data/model/get_members_model.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/contact_list_state.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsList extends StatelessWidget {
  final ContactListCubit cubit;
  final List<Contact> contacts;

  const ContactsList({super.key, required this.cubit, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactListCubit, ContactListState>(
      bloc: cubit,
      builder: (context, state) {
        final List<MemberListItemData> items;
        if (cubit.isSearching) {
          items = _buildContactItemsFromContacts(cubit, contacts);
        } else {
          final memberItems = _buildMemberItems(cubit, contacts);
          items = memberItems.isNotEmpty
              ? memberItems
              : _buildContactItemsFromContacts(cubit, contacts);
        }

        if (items.isEmpty) {
          return Center(
            child: Text(
              'No contacts found',
              style: AppTextStyles.body(context),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: items.length,
          separatorBuilder: (_, _) =>
              Divider(color: Colors.white.withValues(alpha: 0.15), height: 1),
          itemBuilder: (context, index) {
            final item = items[index];
            final contact = item.contact;
            final isInviteOnly = !item.isFennec;

            // Determine if selected
            bool isSelected = false;
            if (contact != null) {
              isSelected = cubit.isMemberSelected(
                contact,
                memberId: item.memberId,
              );
            } else if (isInviteOnly == false && item.memberId != null) {
              // API Fennec member without local contact
              isSelected = cubit.isApiMemberSelected(item.memberId!);
            }

            // Create callback for adding
            final addCallback = !isInviteOnly
                ? () {
                    if (contact != null) {
                      cubit.addMember(
                        contact,
                        emailOverride: item.email,
                        memberId: item.memberId,
                      );
                    } else if (item.memberId != null) {
                      // API Fennec member without local contact
                      cubit.addApiMember(
                        item.memberId!,
                        email: item.email,
                        phone: item.phone,
                      );
                    }
                  }
                : null;

            return ContactListItem(
              name: item.name,
              email: item.email,
              phone: item.phone,
              isSelected: isSelected,
              isInviteOnly: isInviteOnly,
              onAdd: addCallback,
              onInvite: isInviteOnly
                  ? () {
                      cubit.sendGroupInvite(
                        email: item.email,
                        phone: item.phone,
                      );
                    }
                  : null,
            );
          },
        );
      },
    );
  }

  List<MemberListItemData> _buildMemberItems(
    ContactListCubit cubit,
    List<Contact> contacts,
  ) {
    final fennecMembers = cubit.fennecMembers;
    final nonFennecMembers = cubit.nonFennecMembers;

    if (fennecMembers.isEmpty && nonFennecMembers.isEmpty) {
      return [];
    }

    final contactByPhone = _buildContactByPhone(contacts);
    final items = <MemberListItemData>[];

    for (final member in fennecMembers) {
      final phone = member.phone ?? '';
      final phoneKey = _normalizePhone(phone);
      final contact = _resolveContactByPhone(phoneKey, contactByPhone);
      final nameParts = [member.firstName, member.lastName]
          .whereType<String>()
          .map((p) => p.trim())
          .where((p) => p.isNotEmpty)
          .toList();
      final displayName = nameParts.isNotEmpty
          ? nameParts.join(' ')
          : (contact?.displayName ?? 'Member');
      final email =
          member.email ??
          (contact?.emails.isNotEmpty == true
              ? contact!.emails.first.address
              : '');

      items.add(
        MemberListItemData(
          name: displayName,
          email: email,
          phone: phone,
          contact: contact,
          isFennec: true,
          memberId: member.id,
        ),
      );
    }

    for (final member in nonFennecMembers) {
      final rawPhone = member.phone ?? member.invitePhone ?? '';
      final phoneKey = _normalizePhone(rawPhone);
      final contact = _resolveContactByPhone(phoneKey, contactByPhone);
      final displayName = contact?.displayName ?? 'Invite';
      final email = contact?.emails.isNotEmpty == true
          ? contact!.emails.first.address
          : '';

      items.add(
        MemberListItemData(
          name: displayName,
          email: email,
          phone: rawPhone,
          contact: contact,
          isFennec: false,
        ),
      );
    }

    return items;
  }

  List<MemberListItemData> _buildContactItemsFromContacts(
    ContactListCubit cubit,
    List<Contact> contacts,
  ) {
    final fennecPhoneMap = _buildFennecPhoneMap(cubit.fennecMembers);
    return contacts.map((contact) {
      final email = contact.emails.isNotEmpty
          ? contact.emails.first.address
          : '';
      final phone = contact.phones.isNotEmpty
          ? contact.phones.first.number
          : '';
      final phoneKey = _normalizePhone(phone);
      final last10 = _lastDigits(phoneKey, 10);
      final isFennec =
          fennecPhoneMap.containsKey(phoneKey) ||
          (last10.isNotEmpty && fennecPhoneMap.containsKey(last10));

      return MemberListItemData(
        name: contact.displayName,
        email: email,
        phone: phone,
        contact: contact,
        isFennec: isFennec,
      );
    }).toList();
  }

  Map<String, bool> _buildFennecPhoneMap(List<Member> members) {
    final map = <String, bool>{};
    for (final member in members) {
      final rawPhone = member.phone ?? '';
      final phoneKey = _normalizePhone(rawPhone);
      if (phoneKey.isEmpty) continue;
      map[phoneKey] = true;
      final last10 = _lastDigits(phoneKey, 10);
      if (last10.isNotEmpty) {
        map[last10] = true;
      }
    }
    return map;
  }

  Map<String, Contact> _buildContactByPhone(List<Contact> contacts) {
    final map = <String, Contact>{};
    for (final contact in contacts) {
      if (contact.phones.isEmpty) continue;
      for (final phone in contact.phones) {
        final phoneKey = _normalizePhone(phone.number);
        if (phoneKey.isEmpty) continue;
        map.putIfAbsent(phoneKey, () => contact);
        final last10 = _lastDigits(phoneKey, 10);
        if (last10.isNotEmpty) {
          map.putIfAbsent(last10, () => contact);
        }
      }
    }
    return map;
  }

  Contact? _resolveContactByPhone(
    String phoneKey,
    Map<String, Contact> contactByPhone,
  ) {
    if (phoneKey.isEmpty) return null;
    final direct = contactByPhone[phoneKey];
    if (direct != null) return direct;
    final last10 = _lastDigits(phoneKey, 10);
    if (last10.isEmpty) return null;
    return contactByPhone[last10];
  }

  String _normalizePhone(String raw) {
    return raw.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _lastDigits(String raw, int count) {
    if (raw.isEmpty) return '';
    if (raw.length <= count) return raw;
    return raw.substring(raw.length - count);
  }
}

class ContactListItem extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final bool isSelected;
  final bool isInviteOnly;
  final VoidCallback? onAdd;
  final VoidCallback? onInvite;

  const ContactListItem({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.isSelected,
    required this.isInviteOnly,
    required this.onAdd,
    required this.onInvite,
  });

  @override
  Widget build(BuildContext context) {
    final String displayName = name.isNotEmpty ? name : 'Unknown';
    final String displayPhone = phone;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: isLightTheme(context)
                    ? ColorPalette.textGrey
                    : ColorPalette.secondary.withValues(alpha: 0.5),
                child: Text(
                  displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                  style: AppTextStyles.h4(context).copyWith(
                    color: isLightTheme(context)
                        ? ColorPalette.primary
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayName,
                      style: AppTextStyles.h4(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (email.isNotEmpty || displayPhone.isNotEmpty)
                      const SizedBox(height: 4),
                    if (email.isNotEmpty)
                      Text(
                        email,
                        style: AppTextStyles.bodySmall(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (displayPhone.isNotEmpty)
                      Text(
                        displayPhone,
                        style: AppTextStyles.bodySmall(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: isInviteOnly ? onInvite : (isSelected ? null : onAdd),
                child: Container(
                  height: 28,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        isSelected &&
                            Theme.of(context).brightness == Brightness.light
                        ? ColorPalette.textGrey
                        : ColorPalette.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    isInviteOnly ? 'Invite' : (isSelected ? 'Added' : 'Add'),
                    style: AppTextStyles.chipLabel(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected &&
                              Theme.of(context).brightness == Brightness.light
                          ? ColorPalette.primary
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: isLightTheme(context)
              ? Colors.black.withValues(alpha: 0.08)
              : Colors.white.withValues(alpha: 0.08),
          height: 1,
        ),
      ],
    );
  }
}

class MemberListItemData {
  final String name;
  final String email;
  final String phone;
  final Contact? contact;
  final bool isFennec;
  final String? memberId;

  const MemberListItemData({
    required this.name,
    required this.email,
    required this.phone,
    required this.contact,
    required this.isFennec,
    this.memberId,
  });
}
