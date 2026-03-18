import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/create_group_header.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/group_basic_settings.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/group_title_field.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/group_bio_field.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/group_interests_selection.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/selected_members_list.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/state/contact_list_state.dart';

class CreateGroupContent extends StatefulWidget {
  final bool isEditMode;

  const CreateGroupContent({super.key, this.isEditMode = false});

  @override
  State<CreateGroupContent> createState() => _CreateGroupContentState();
}

class _CreateGroupContentState extends State<CreateGroupContent> {
  late TextEditingController _bioController;
  late TextEditingController _groupTitleController;
  final ScrollController _scrollController = ScrollController();
  final cubit = Di().sl<CreateGroupCubit>();
  final contactListCubit = Di().sl<ContactListCubit>();
  final MyGroupCubit _myGroupCubit = Di().sl<MyGroupCubit>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with cubit data
    _bioController = TextEditingController(text: cubit.groupBio);
    _groupTitleController = TextEditingController(text: cubit.groupTitle);

    // If in edit mode, preload data from API
    if (widget.isEditMode && _myGroupCubit.myGroupModel?.data != null) {
      final groupData = _myGroupCubit.myGroupModel!.data!;
      final bio = groupData.bio ?? '';
      final title = groupData.titleMembers ?? '';
      final category = groupData.fitsForGroup ?? '';

      cubit.updateGroupBio(bio);
      cubit.updateGroupTitle(title);
      cubit.updateGroupCategory(category);
      cubit.updateCanInviteMembers(
        groupData.groupSettings?.anyoneCanInviteMembers ?? false,
      );
      cubit.updateCanUpdatePhotosVideos(
        groupData.groupSettings?.anyoneCanUpdatePhotosVideos ?? false,
      );
      cubit.updateCanUpdatePrompts(
        groupData.groupSettings?.anyoneCanUpdatePrompts ?? false,
      );

      if (category.isNotEmpty) {
        cubit.updateSelectedInterests(_mapCategoryToInterestKey(category));
      }

      _bioController.text = bio;
      _groupTitleController.text = title;
    }

    // Auto-load contacts if permission is already granted
    final hasContacts =
        contactListCubit.contacts != null &&
        contactListCubit.contacts!.isNotEmpty;
    if (!hasContacts) {
      contactListCubit.checkPermissionAndLoad();
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _groupTitleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<String> _mapCategoryToInterestKey(String category) {
    const interestKeyMap = {
      "travel & adventure": "travel",
      "music & arts": "music",
      "food & drink": "food",
      "wellness & lifestyle": "wellness",
      "sports & outdoors": "sports",
      "events & parties": "events",
    };
    final interestKey = interestKeyMap[category] ?? category;
    return [interestKey];
  }

  @override
  Widget build(BuildContext context) {
    final canEditCoreDetails =
        !widget.isEditMode || cubit.canCurrentUserEditCoreDetails();
    final canEditMembers =
        !widget.isEditMode || cubit.canCurrentUserInviteMembers();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CreateGroupHeader(),
          BlocBuilder<ContactListCubit, ContactListState>(
            bloc: contactListCubit,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: AppText(
                      text: 'Add Members',
                      style: AppTextStyles.h3(context),
                    ),
                  ),
                  const CustomSizedBox(height: 20),
                  SelectedMembersList(
                    contactListCubit: contactListCubit,
                    isEditMode: widget.isEditMode,
                    canEditMembers: canEditMembers,
                    editMembers:
                        _myGroupCubit.myGroupModel?.data?.members ?? [],
                  ),
                  const CustomSizedBox(height: 24),
                  GroupTitleField(
                    cubit: cubit,
                    controller: _groupTitleController,
                    readOnly: !canEditCoreDetails,
                  ),
                  const CustomSizedBox(height: 24),
                  GroupBioField(
                    cubit: cubit,
                    controller: _bioController,
                    scrollController: _scrollController,
                    readOnly: !canEditCoreDetails,
                  ),
                  const CustomSizedBox(height: 24),
                  GroupInterestsSelection(
                    cubit: cubit,
                    isEditable: canEditCoreDetails,
                  ),
                  const CustomSizedBox(height: 24),
                  GroupBasicSettings(isEditMode: widget.isEditMode),
                ],
              );
            },
          ),
          const CustomSizedBox(height: 130),
        ],
      ),
    );
  }
}
