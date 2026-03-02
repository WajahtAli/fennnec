import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/contact_list_state.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/add_member_body.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/add_member_search_bar.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final contactListCubit = Di().sl<ContactListCubit>();

  @override
  void initState() {
    super.initState();
    final hasContacts =
        contactListCubit.contacts != null &&
        contactListCubit.contacts!.isNotEmpty;
    if (!hasContacts) {
      contactListCubit.checkPermissionAndLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MovableBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<ContactListCubit, ContactListState>(
            bloc: contactListCubit,
            builder: (context, state) {
              final contacts = contactListCubit.isSearching
                  ? contactListCubit.searchedContacts ?? []
                  : contactListCubit.contacts ?? [];
              final selectedMembers = contactListCubit.selectedMembers;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SafeArea(
                    child: Row(
                      children: [
                        const CustomBackButton(),
                        const Spacer(),
                        Text('Add Member', style: AppTextStyles.h4(context)),
                        const Spacer(),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AddMemberSearchBar(cubit: contactListCubit),
                  const SizedBox(height: 16),
                  Flexible(
                    child: AddMemberBody(
                      state: state,
                      cubit: contactListCubit,
                      contacts: contacts,
                      selectedMembers: selectedMembers,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
