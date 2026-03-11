import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/usecase/create_group_usecase.dart';
import '../state/create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final CreateGroupUsecase _createGroupUsecase;

  CreateGroupCubit(this._createGroupUsecase) : super(CreateGroupInitial());

  String groupBio = '';
  String groupTitle = '';
  String fitsForGroup = '';
  Map<String, dynamic> groupSettings = {};
  List<String> photosVideos = [];
  List<String> selectedInterests = [];
  bool canInviteMembers = true;
  bool canUpdatePhotosVideos = true;
  bool canUpdatePrompts = true;
  String? createdGroupId;

  Future<void> openSettings() async {
    await openAppSettings();
  }

  void setSelectedInterests(List<String> interests) {
    selectedInterests = interests;
    if (interests.isNotEmpty) {
      final interestMap = {
        'travel': 'travel & adventure',
        'music': 'music & arts',
        'food': 'food & drink',
        'wellness': 'wellness & lifestyle',
        'sports': 'sports & outdoors',
        'events': 'events & parties',
      };
      fitsForGroup = interestMap[interests.first] ?? '';
    }
  }

  Future<void> executeCreateGroup(BuildContext context) async {
    if (fitsForGroup.isEmpty) {
      VxToast.show(message: 'Please fill in all required fields');
      return;
    }

    emit(CreateGroupLoading());

    try {
      final contactListCubit = Di().sl<ContactListCubit>();
      final selectedApiMemberIds = contactListCubit.selectedMembers
          .where((m) => m.isFennecUser && m.fennecId != null)
          .map((m) => m.fennecId!)
          .toList();

      log('📊 executeCreateGroup called');
      log('📊 selectedApiMemberIds count: ${selectedApiMemberIds.length}');
      log('📊 selectedApiMemberIds: $selectedApiMemberIds');

      final List<String> members = List<String>.from(selectedApiMemberIds);
      log('📊 Final members array to send: $members');
      log('📊 photo videos: $photosVideos');

      final response = await _createGroupUsecase.createGroup(
        title: groupTitle,
        members: members,
        bio: groupBio,
        fitsForGroup: fitsForGroup,
        groupSettings: groupSettings,
        photosVideos: Di()
            .sl<ImagePickerCubit>()
            .mediaList
            .map((e) => e.path)
            .toList(),
      );

      // Extract and store group ID from response
      if (response.data != null) {
        final data = response.data;
        createdGroupId = data?.id;
        log('✅ Created group ID: $createdGroupId');
      }

      VxToast.show(
        message: 'Group created successfully',
        icon: Assets.icons.checkGreen.path,
      );

      emit(CreateGroupSuccess());
    } catch (e) {
      String errorMsg = 'Failed to create group';
      if (e is Map<String, dynamic>) {
        errorMsg = e['message']?.toString() ?? errorMsg;
      } else {
        errorMsg = e.toString();
      }

      VxToast.show(message: errorMsg);
      emit(CreateGroupError(errorMsg));
    }
  }

  String groupId = "";

  Future<void> createGroup({required BuildContext context}) async {
    final createAccountCubit = Di().sl<CreateAccountCubit>();
    final imagePickerCubit = Di().sl<ImagePickerCubit>();
    final contactListCubit = Di().sl<ContactListCubit>();

    photosVideos = imagePickerCubit.mediaList.map((e) => e.path).toList();

    emit(CreateGroupLoading());

    try {
      final loginCubit = Di().sl<LoginCubit>();
      final currentUserId = loginCubit.userData?.user?.id;

      final List<String> members = [];

      if (currentUserId != null && currentUserId.isNotEmpty) {
        members.add(currentUserId);
      }

      members.addAll(
        contactListCubit.selectedMembers
            .where((m) => m.isFennecUser && m.fennecId != null)
            .map((m) => m.fennecId!)
            .toList(),
      );

      List<String> meadiaLinks = [];
      createAccountCubit.mediaLinks.clear();

      for (var i in photosVideos) {
        try {
          log("📤 Uploading media: $i");
          await createAccountCubit.uploadMedia(filePath: i);

          if (createAccountCubit.mediaLinks.isNotEmpty) {
            log(
              "✅ Media uploaded successfully: ${createAccountCubit.mediaLinks.last}",
            );
          } else {
            log("⚠️ Media upload returned but no link was recorded for: $i");
          }
        } catch (uploadError) {
          log("❌ Error uploading media: $uploadError");
        }
      }

      meadiaLinks.addAll(createAccountCubit.mediaLinks);

      groupSettings = {
        'anyoneCanInviteMembers': canInviteMembers,
        'anyoneCanUpdatePhotosVideos': canUpdatePhotosVideos,
        'anyoneCanUpdatePrompts': canUpdatePrompts,
      };

      var response = await _createGroupUsecase.createGroup(
        title: groupTitle,
        members: members,
        bio: groupBio,
        fitsForGroup: fitsForGroup,
        groupSettings: groupSettings,
        photosVideos: meadiaLinks,
      );
      groupId = response.data?.id ?? "";
      meadiaLinks.clear();
      createAccountCubit.mediaLinks.clear();
      Di().sl<KycPromptCubit>().resetAllData();
      context.router.push(
        KycPromptRoute(showSkipButton: false, title: "Create a Group"),
      );
      VxToast.show(
        message: 'Group created successfully',
        icon: Assets.icons.checkGreen.path,
      );

      emit(CreateGroupSuccess());
    } catch (e) {
      VxToast.show(message: e.toString());
      emit(CreateGroupError(e.toString()));
    }
  }

  Future<void> updateGroupWithChangedFields({required String groupId}) async {
    emit(CreateGroupLoading());

    try {
      final myGroupCubit = Di().sl<MyGroupCubit>();
      final contactListCubit = Di().sl<ContactListCubit>();
      final CreateAccountCubit createAccountCubit = Di()
          .sl<CreateAccountCubit>();
      final ImagePickerCubit imagePickerCubit = Di().sl<ImagePickerCubit>();

      final groupData = myGroupCubit.myGroupModel?.data;

      final baseSettings = groupData?.groupSettings;
      final updatedSettings =
          baseSettings?.copyWith(
            anyoneCanInviteMembers: canInviteMembers,
            anyoneCanUpdatePhotosVideos: canUpdatePhotosVideos,
            anyoneCanUpdatePrompts: canUpdatePrompts,
          ) ??
          baseSettings;

      List<String> finalMedia = imagePickerCubit.mediaList
          .map((e) => e.path)
          .toList();
      log("finalMedia: $finalMedia");

      final updatedGroupData = groupData?.copyWith(
        titleMembers: groupTitle.isEmpty ? groupData.titleMembers : groupTitle,
        bio: groupBio.isEmpty ? groupData.bio : groupBio,
        members: contactListCubit.selectedMembers
            .where((m) => m.isFennecUser && m.fennecId != null)
            .map(
              (m) => CreatedBy(
                id: m.fennecId,
                email: m.email,
                firstName: m.displayName.split(' ').first,
                lastName: m.displayName.split(' ').skip(1).join(' '),
                image: m.profileImageUrl,
              ),
            )
            .toList(),
        fitsForGroup: fitsForGroup.isEmpty
            ? groupData.fitsForGroup
            : fitsForGroup,
        groupSettings: updatedSettings,
        photosVideos: finalMedia.isNotEmpty
            ? finalMedia
            : (groupData.photosVideos ?? const <String>[]),
      );

      final Map<String, dynamic> updateBody = {};

      if (updatedGroupData?.titleMembers != groupData?.titleMembers) {
        updateBody['title'] = updatedGroupData?.titleMembers;
      }

      if (updatedGroupData?.bio != groupData?.bio) {
        updateBody['bio'] = updatedGroupData?.bio;
      }

      if (updatedGroupData?.fitsForGroup != groupData?.fitsForGroup) {
        updateBody['fitsForGroup'] = updatedGroupData?.fitsForGroup;
      }

      if (updatedSettings != null &&
          updatedSettings.toJson() != baseSettings?.toJson()) {
        updateBody['groupSettings'] = {
          'anyoneCanInviteMembers': updatedSettings.anyoneCanInviteMembers,
          'anyoneCanUpdatePhotosVideos':
              updatedSettings.anyoneCanUpdatePhotosVideos,
          'anyoneCanUpdatePrompts': updatedSettings.anyoneCanUpdatePrompts,
        };
      }

      final originalPhotosVideos = groupData?.photosVideos ?? const <String>[];

      if (updatedGroupData?.photosVideos != null &&
          !listEquals(updatedGroupData!.photosVideos!, originalPhotosVideos)) {
        updateBody['photosVideos'] = updatedGroupData.photosVideos;
      }

      // final originalMembers = (groupData?.members ?? [])
      //     .map((member) => member.id ?? '')
      //     .where((id) => id.isNotEmpty)
      //     .toList(growable: false);

      final selectedApiMemberIds = contactListCubit.selectedMembers
          .where((m) => m.isFennecUser && m.fennecId != null)
          .map((m) => m.fennecId!)
          .toList();
      log(' Selected API member IDs for update: $selectedApiMemberIds');
      // log('📊 Original member IDs: $originalMembers');

      // Simplified member update logic for now as Contact logic is moved.
      // if (selectedApiMemberIds.isNotEmpty &&
      //     !listEquals(selectedApiMemberIds, originalMembers)) {
      updateBody['members'] = selectedApiMemberIds;
      // }

      // If nothing changed, just show success
      if (updateBody.isEmpty) {
        VxToast.show(message: 'No changes to update');
        emit(CreateGroupLoaded());
        return;
      }

      log('📊 Updating group with changed fields: $updateBody');

      // Call MyGroupCubit update method
      await myGroupCubit.updateGroupById(groupId, updateBody);
      createAccountCubit.mediaLinks.clear();
      Di().sl<MyGroupCubit>().updateMyGroupDataLocal(updatedGroupData!);
      VxToast.show(message: 'Group updated successfully');
      emit(CreateGroupLoaded());
    } catch (e) {
      emit(CreateGroupError(e.toString()));

      VxToast.show(message: e.toString());
    }
  }

  // Methods to update group data
  void updateGroupTitle(String title) {
    groupTitle = title;
    emit(CreateGroupLoaded());
  }

  void updateGroupBio(String bio) {
    groupBio = bio;
    emit(CreateGroupLoaded());
  }

  void updateGroupCategory(String category) {
    emit(CreateGroupLoading());

    fitsForGroup = category;
    emit(CreateGroupLoaded());
  }

  void updateCanInviteMembers(bool value) {
    emit(CreateGroupLoading());
    canInviteMembers = value;
    emit(CreateGroupLoaded());
  }

  void updateCanUpdatePhotosVideos(bool value) {
    emit(CreateGroupLoading());

    canUpdatePhotosVideos = value;
    emit(CreateGroupLoaded());
  }

  void updateCanUpdatePrompts(bool value) {
    emit(CreateGroupLoading());

    canUpdatePrompts = value;
    emit(CreateGroupLoaded());
  }

  void updateSelectedInterests(List<String> interests) {
    selectedInterests = interests;
    if (interests.isNotEmpty) {
      final interestMap = {
        'travel': 'travel & adventure',
        'music': 'music & arts',
        'food': 'food & drink',
        'wellness': 'wellness & lifestyle',
        'sports': 'sports & outdoors',
        'events': 'events & parties',
      };
      fitsForGroup = interestMap[interests.first] ?? '';
    } else {
      fitsForGroup = '';
    }
    emit(CreateGroupLoaded());
  }

  void toggleInterest(String interest) {
    emit(CreateGroupLoading());
    if (selectedInterests.contains(interest)) {
      updateSelectedInterests([]);
    } else {
      updateSelectedInterests([interest]);
    }
    emit(CreateGroupLoaded());
  }

  // reset all data
  void resetAllData() {
    groupTitle = '';
    groupBio = '';
    fitsForGroup = '';
    canInviteMembers = false;
    canUpdatePhotosVideos = false;
    canUpdatePrompts = false;
    selectedInterests = [];
    photosVideos = [];
    Di().sl<ContactListCubit>().resetAllData();
    Di().sl<KycPromptCubit>().resetAllData();
    emit(CreateGroupLoaded());
  }
}
