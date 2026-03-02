import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/contact_list_state.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/contacts_list.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/permission_denied_view.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/permission_permanently_denied_view.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/permission_request_card.dart';
import 'package:fennac_app/skeletons/contacts/contacts_skeleton.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

class AddMemberBody extends StatelessWidget {
  final ContactListState state;
  final ContactListCubit cubit;
  final List<Contact> contacts;
  final List<Contact> selectedMembers;

  const AddMemberBody({
    super.key,
    required this.state,
    required this.cubit,
    required this.contacts,
    required this.selectedMembers,
  });

  @override
  Widget build(BuildContext context) {
    if (state is ContactListInitial) {
      return PermissionRequestCard(
        onAllow: cubit.requestAccessAndLoadContacts,
        onDeny: cubit.denyAccess,
      );
    }
    if (state is ContactListPermissionDenied) {
      return const PermissionDeniedView();
    }
    if (state is ContactListPermissionPermanentlyDenied) {
      return PermissionPermanentlyDeniedView(
        onOpenSettings: cubit.openSettings,
        onRetry: cubit.requestAccessAndLoadContacts,
      );
    }
    if (state is ContactListLoading) {
      return const ContactsSkeletonLoader();
    }
    if (state is ContactListError) {
      return Center(child: Text('Error', style: AppTextStyles.body(context)));
    }

    return ContactsList(cubit: cubit, contacts: contacts);
  }
}
