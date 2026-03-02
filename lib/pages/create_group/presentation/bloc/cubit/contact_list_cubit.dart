import 'dart:developer';

import 'package:fast_contacts/fast_contacts.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/create_group/data/model/get_members_model.dart';
import 'package:fennac_app/pages/create_group/domain/usecase/create_group_usecase.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/contact_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListCubit extends Cubit<ContactListState> {
  final CreateGroupUsecase _createGroupUsecase;

  ContactListCubit(this._createGroupUsecase) : super(ContactListInitial());

  List<Contact>? contacts;
  List<Contact>? searchedContacts;
  bool isSearching = false;
  final searchController = TextEditingController();
  final List<Contact> selectedMembers = [];
  final List<String> selectedApiMemberIds = [];
  GetMembersModel? membersModel;
  List<Member> fennecMembers = [];
  List<NotFennecMember> nonFennecMembers = [];

  Future<void> requestAccessAndLoadContacts() async {
    emit(ContactListLoading());

    try {
      final status = await Permission.contacts.status;

      if (status.isGranted) {
        contacts = await FastContacts.getAllContacts();
        await getAllMembers(
          contacts: contacts!
              .map(
                (c) => c.phones.isNotEmpty
                    ? c.phones.first.number.replaceAll(RegExp(r'[^0-9+]'), '')
                    : '',
              )
              .toList(),
        );
        emit(ContactListLoaded());
        return;
      }

      if (status.isDenied) {
        final result = await Permission.contacts.request();

        if (result.isGranted) {
          contacts = await FastContacts.getAllContacts();
          await getAllMembers(
            contacts: contacts!
                .map(
                  (c) => c.phones.isNotEmpty
                      ? c.phones.first.number.replaceAll(RegExp(r'[^0-9+]'), '')
                      : '',
                )
                .toList(),
          );
          emit(ContactListLoaded());
        } else if (result.isPermanentlyDenied) {
          emit(ContactListPermissionPermanentlyDenied());
        } else {
          emit(ContactListPermissionDenied());
        }
        return;
      }

      if (status.isPermanentlyDenied) {
        emit(ContactListPermissionPermanentlyDenied());
      }
    } catch (e, s) {
      log('Contacts access failed', error: e, stackTrace: s);
      emit(ContactListError('Failed to load contacts'));
    }
  }

  Future<void> checkPermissionAndLoad() async {
    try {
      final status = await Permission.contacts.status;
      if (status.isGranted) {
        await requestAccessAndLoadContacts();
      }
    } catch (e) {
      log('Check permission failed', error: e);
    }
  }

  void openSettings() async {
    await openAppSettings();
  }

  void denyAccess() {
    emit(ContactListPermissionDenied());
  }

  void addMember(Contact contact, {String? emailOverride, String? memberId}) {
    emit(ContactListLoading());

    if (selectedMembers.length + selectedApiMemberIds.length >= 4) {
      VxToast.show(message: 'You can add up to 4 members in a group.');
      emit(ContactListLoaded());
      return;
    }

    // Check if member is already added locally
    final alreadyAddedLocally = selectedMembers.any((c) => c.id == contact.id);
    // Check if member is already added as API member
    final isAlreadyAddedAsApiMember = selectedApiMemberIds.contains(memberId);

    // If this is a Fennec member (has memberId), ONLY add to selectedApiMemberIds
    if (memberId != null && memberId.isNotEmpty) {
      if (!isAlreadyAddedAsApiMember) {
        selectedApiMemberIds.add(memberId);
        log(
          'ContactListCubit: added Fennec member ID $memberId to selectedApiMemberIds',
        );
        final email = (emailOverride != null && emailOverride.trim().isNotEmpty)
            ? emailOverride.trim()
            : (contact.emails.isNotEmpty ? contact.emails.first.address : null);
        final phone = contact.phones.isNotEmpty
            ? contact.phones.first.number.replaceAll(RegExp(r'[^0-9+]'), '')
            : null;
        sendGroupInvite(email: email, phone: phone);
      }
    } else if (!alreadyAddedLocally) {
      // If not a Fennec member, add as local contact only
      selectedMembers.add(contact);
      log('ContactListCubit: added local member ${contact.displayName}');
      final email = (emailOverride != null && emailOverride.trim().isNotEmpty)
          ? emailOverride.trim()
          : (contact.emails.isNotEmpty ? contact.emails.first.address : null);
      final phone = contact.phones.isNotEmpty
          ? contact.phones.first.number.replaceAll(RegExp(r'[^0-9+]'), '')
          : null;
      sendGroupInvite(email: email, phone: phone);
    }

    emit(ContactListLoaded());
  }

  bool isMemberSelected(Contact contact, {String? memberId}) {
    // Check if member is in selectedMembers (local contacts)
    if (selectedMembers.any((c) => c.id == contact.id)) {
      return true;
    }

    // Check if member is in selectedApiMemberIds (Fennec members)
    if (memberId != null &&
        memberId.isNotEmpty &&
        selectedApiMemberIds.contains(memberId)) {
      return true;
    }

    return false;
  }

  void removeMember(int memberIndex) {
    emit(ContactListLoading());
    if (memberIndex >= 0 && memberIndex < selectedMembers.length) {
      final removed = selectedMembers.removeAt(memberIndex);
      emit(ContactListLoaded());
      log('ContactListCubit: removed member ${removed.displayName}');
    }
  }

  void addApiMember(String memberId, {String? email, String? phone}) {
    emit(ContactListLoading());

    if (selectedMembers.length + selectedApiMemberIds.length >= 4) {
      VxToast.show(message: 'You can add up to 4 members in a group.');
      emit(ContactListLoaded());
      return;
    }

    if (!selectedApiMemberIds.contains(memberId)) {
      selectedApiMemberIds.add(memberId);
      log('ContactListCubit: added API member $memberId');
      sendGroupInvite(email: email, phone: phone);
    }

    emit(ContactListLoaded());
  }

  void removeApiMember(String memberId) {
    emit(ContactListLoading());
    if (selectedApiMemberIds.remove(memberId)) {
      log('ContactListCubit: removed API member $memberId');
    }
    emit(ContactListLoaded());
  }

  bool isApiMemberSelected(String memberId) {
    return selectedApiMemberIds.contains(memberId);
  }

  Future<void> sendGroupInvite({
    String? email,
    String? phone,
    String? groupId,
  }) async {
    if ((email == null || email.trim().isEmpty) &&
        (phone == null || phone.trim().isEmpty)) {
      return;
    }
    try {
      final response = await _createGroupUsecase.sendGroupInvite(
        email: email,
        phone: phone,
        groupId: groupId,
      );
      final message = response is Map<String, dynamic>
          ? response['message']?.toString()
          : null;
      VxToast.show(
        message: message ?? 'Invite sent',
        icon: Assets.icons.checkGreen.path,
      );
    } catch (e) {
      String errorMsg = 'Failed to send invite';
      if (e is Map<String, dynamic>) {
        errorMsg = e['message']?.toString() ?? errorMsg;
      } else {
        errorMsg = e.toString();
      }
      VxToast.show(message: errorMsg);
    }
  }

  void searchContacts(String query) {
    emit(ContactListLoading());

    if (query.trim().isEmpty) {
      clearSearch();
      return;
    }
    isSearching = true;
    searchedContacts = contacts?.where((contact) {
      final name = contact.displayName.toLowerCase();
      final q = query.toLowerCase().trim();

      final phoneMatch = contact.phones.any(
        (phone) =>
            phone.number.replaceAll(' ', '').contains(q.replaceAll(' ', '')),
      );

      return name.contains(q) || phoneMatch;
    }).toList();

    emit(ContactListLoaded());
  }

  void clearSearch() {
    emit(ContactListLoading());
    searchController.clear();
    searchedContacts = null;
    isSearching = false;
    emit(ContactListLoaded());
  }

  Future<GetMembersModel?> getAllMembers({
    required List<String> contacts,
  }) async {
    // Only emit loading if not already loading (optional optimization, but good for UI flicker)
    // emit(ContactListLoading());

    try {
      final response = await _createGroupUsecase.getAllMembers(
        contacts: contacts,
      );

      membersModel = response;
      fennecMembers = response.data?.members ?? [];
      nonFennecMembers = response.data?.notFennecMembers ?? [];

      // emit(ContactListLoaded());
      return response;
    } catch (e) {
      String errorMsg = 'Failed to get members';
      if (e is Map<String, dynamic>) {
        errorMsg = e['message']?.toString() ?? errorMsg;
      } else {
        errorMsg = e.toString();
      }

      VxToast.show(message: errorMsg);
      emit(ContactListError(errorMsg));
      return null;
    }
  }

  // reset all data
  void resetAllData() {
    isSearching = false;
    selectedMembers.clear();
    selectedApiMemberIds.clear();
    membersModel = null;
    fennecMembers.clear();
    nonFennecMembers.clear();
    emit(ContactListLoaded());
  }
}
