import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:fennac_app/pages/create_group/presentation/screen/create_group_gallery_screen.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/state/my_group_state.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/skeletons/edit_group_skeleton.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:math' as math;
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import '../../../../reusable_widgets/custom_video_player.dart';
import '../../../../reusable_widgets/group_card.dart' show GroupCard;
import '../../../../reusable_widgets/group_settings_widget.dart';
import '../../data/model/my_group_model.dart';

enum EditableGroupCardType { image, title, bio, category, settings, prompt }

@RoutePage()
class EditGroupScreen extends StatefulWidget {
  final String groupId;

  const EditGroupScreen({super.key, required this.groupId});

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final MyGroupCubit _myGroupCubit = Di().sl<MyGroupCubit>();

  late TextEditingController _titleController;
  late TextEditingController _bioController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bioController = TextEditingController();
    _categoryController = TextEditingController();

    Future.microtask(() {
      _myGroupCubit.fetchGroupById(widget.groupId);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bioController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: BlocConsumer<MyGroupCubit, MyGroupState>(
              bloc: _myGroupCubit,
              listener: (context, state) {
                if (state is MyGroupLoaded) {
                  final groupData = _myGroupCubit.myGroupModel?.data;
                  if (groupData != null) {
                    _titleController.text = groupData.titleMembers ?? '';
                    _bioController.text = groupData.bio ?? '';
                    _categoryController.text = groupData.fitsForGroup ?? '';
                  }
                }
              },
              builder: (context, state) {
                if (state is MyGroupLoading) {
                  return Column(
                    children: [
                      CustomAppBar(title: 'Edit Group'),
                      const CustomSizedBox(height: 24),
                      const EditGroupSkeleton(),
                    ],
                  );
                }

                if (state is MyGroupError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppTextStyles.body(
                        context,
                      ).copyWith(color: Colors.red),
                    ),
                  );
                }

                final groupData = _myGroupCubit.myGroupModel?.data;
                final avatarPaths =
                    groupData?.members
                        ?.map((member) => member.image ?? '')
                        .toList() ??
                    [];
                final avatarInitials =
                    groupData?.members
                        ?.map((member) => validateString(member.firstName))
                        .toList() ??
                    [];
                if (groupData == null) {
                  return Center(
                    child: Text(
                      'No group data availble',
                      style: AppTextStyles.body(context),
                    ),
                  );
                }

                return Column(
                  children: [
                    CustomAppBar(title: 'Edit Group'),
                    const CustomSizedBox(height: 24),

                    // Group Avatar Section
                    _buildGroupAvatarSection(context),
                    const CustomSizedBox(height: 24),

                    // MyGroupCard(isEditMode: true),
                    GroupCard(
                      title: groupData.titleMembers ?? '',
                      subtitle: groupData.bio ?? '',
                      avatarPaths: avatarPaths,

                      onMenuPressed: () {
                        AutoRouter.of(
                          context,
                        ).push(CreateGroupRoute(isEditMode: true));
                      },
                      chipLabel: groupData.fitsForGroup,
                      memberNames: avatarInitials,
                      isEditMode: true,
                    ),
                    _buildPhotosVideosGrid(context),
                    const CustomSizedBox(height: 24),
                    _buildPromptsSection(context),
                    const CustomSizedBox(height: 24),
                    _buildGroupSettingsSection(context),
                    const CustomSizedBox(height: 32),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupAvatarSection(BuildContext context) {
    final avatarPath =
        (_myGroupCubit.myGroupModel?.data?.photosVideos
            ?.where((e) => e.trim().isNotEmpty)
            .firstOrNull) ??
        DummyConstants.avatarPaths[0];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDarkTheme(context) ? Colors.grey[800] : Colors.grey[300],
              borderRadius: BorderRadius.circular(24),
            ),
            child: avatarPath.startsWith('http')
                ? CachedImageHelper(
                    imageUrl: avatarPath,
                    fit: BoxFit.cover,
                    radius: 24,
                  )
                : Image.asset(avatarPath, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: GestureDetector(
            onTap: () {
              _handleEditTap(context, EditableGroupCardType.image);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorPalette.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                Assets.icons.refreshCcw.path,
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotosVideosGrid(BuildContext context) {
    final photosVideos = _myGroupCubit.myGroupModel?.data?.photosVideos;

    if (_myGroupCubit.myGroupModel?.data?.photosVideos?.isEmpty ?? true) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        alignment: Alignment.center,
        child: Text(
          'No photos or videos yet. Add some to showcase your group!',
          style: AppTextStyles.body(context).copyWith(
            color: isLightTheme(context) ? Colors.black54 : Colors.white54,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: photosVideos?.length ?? 0,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isDarkTheme(context)
                      ? Colors.grey[800]
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: photosVideos?[index].isVideo ?? false
                    ? CustomVideoPlayer(
                        videoUrl: photosVideos?[index] ?? '',
                        aspectRatio: 1,
                        height: 400,
                        borderRadius: BorderRadius.circular(16),
                        showControls: true,
                        sourceType: VideoSourceType.network,
                      )
                    : photosVideos?[index].isImageUrl ?? false
                    ? CachedImageHelper(
                        imageUrl: photosVideos?[index] ?? '',
                        fit: BoxFit.cover,
                        radius: 16,
                      )
                    : Image.asset(
                        photosVideos?[index] ?? '',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Positioned(
              top: 16,
              right: 8,
              child: GestureDetector(
                onTap: () =>
                    _handleEditTap(context, EditableGroupCardType.image),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.edit.path,
                    height: 14,
                    width: 14,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPromptsSection(BuildContext context) {
    final prompts = _myGroupCubit.myGroupModel?.data?.groupPrompts ?? [];

    if (prompts.isEmpty) {
      return Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            alignment: Alignment.center,
            child: PromptAudioRow(
              audioPath: Assets.dummy.audio.group,
              duration: '0:16',
              waveformData: [],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                createGroupCubit.groupId =
                    _myGroupCubit.myGroupModel?.data?.id ?? "";
                Di().sl<KycPromptCubit>().resetAllData();
                int id = DateTime.now().millisecondsSinceEpoch;
                AudioPromptData audioPromptData = AudioPromptData(
                  id: id.toString(),
                  oldId: id.toString(),
                  promptText:
                      "${_myGroupCubit.myGroupModel?.data?.titleMembers} Prompt",
                  promptAnswer: "",
                  isCustom: false,
                  waveformData: List.generate(
                    100,
                    (index) => 0.2 * math.Random().nextDouble(),
                  ),
                  duration: "15:00",
                );
                Di().sl<KycPromptCubit>().addPrompt(audioPromptData);
                _handleEditTap(
                  context,
                  EditableGroupCardType.prompt,
                  isNeedToAddPrompt: true,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorPalette.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  Assets.icons.edit.path,
                  height: 16,
                  width: 16,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prompts',
          style: AppTextStyles.h3(context).copyWith(
            fontWeight: FontWeight.bold,
            color: isLightTheme(context) ? Colors.black : Colors.white,
          ),
        ),
        const CustomSizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: prompts.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final prompt = prompts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildPromptCard(context, prompt),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPromptCard(BuildContext context, GroupPrompt prompt) {
    String promptTitle = prompt.promptTitle?.toString() ?? '';
    String promptAnswer = prompt.promptAnswer?.toString() ?? '';
    String promptType = prompt.type?.toString() ?? 'text';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isDarkTheme(context)
            ? LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: .2),
                  ColorPalette.black.withValues(alpha: .2),
                ],
              )
            : null,
        color: isLightTheme(context) ? ColorPalette.textGrey : null,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(promptTitle, style: AppTextStyles.subHeading(context)),
              const SizedBox(height: 14),
              if (promptType == 'audio' && promptAnswer.isNotEmpty)
                PromptAudioRow(
                  audioPath: promptAnswer,
                  duration: prompt.duration?.toString() ?? '',
                  waveformData: prompt.waves ?? [],
                )
              else
                Text(
                  promptAnswer,
                  style: AppTextStyles.h3(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                createGroupCubit.groupId =
                    _myGroupCubit.myGroupModel?.data?.id ?? "";
                Di().sl<KycPromptCubit>().resetAllData();
                AudioPromptData audioPromptData = AudioPromptData(
                  id: prompt.id,
                  oldId: prompt.id,
                  promptText: promptTitle,
                  promptAnswer: promptAnswer,
                  isCustom: false,
                  waveformData: prompt.waves,
                  duration: prompt.duration?.toString() ?? "15:00",
                );
                Di().sl<KycPromptCubit>().addPrompt(audioPromptData);
                _handleEditTap(
                  context,
                  EditableGroupCardType.prompt,
                  isNeedToAddPrompt: false,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorPalette.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  Assets.icons.edit.path,
                  height: 16,
                  width: 16,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupSettingsSection(BuildContext context) {
    final settings = _myGroupCubit.myGroupModel?.data?.groupSettings;

    return Stack(
      children: [
        GroupSettingsWidget(
          title: 'Group Settings',
          settings: [
            GroupSettingItem(
              label: 'Anyone Can Invite Members',
              value: settings?.anyoneCanInviteMembers ?? false,
              onChanged: (value) {
                // _updateGroupSettings(
                //   value,
                //   settings?.anyoneCanUpdatePhotosVideos ?? false,
                //   settings?.anyoneCanUpdatePrompts ?? false,
                // );
              },
            ),
            GroupSettingItem(
              label: 'Anyone Can Update Photos/Videos',
              value: settings?.anyoneCanUpdatePhotosVideos ?? false,
              onChanged: (value) {
                // _updateGroupSettings(
                //   settings?.anyoneCanInviteMembers ?? false,
                //   value,
                //   settings?.anyoneCanUpdatePrompts ?? false,
                // );
              },
            ),
            GroupSettingItem(
              label: 'Anyone Can Update Prompts',
              value: settings?.anyoneCanUpdatePrompts ?? false,
              onChanged: (value) {
                // _updateGroupSettings(
                //   settings?.anyoneCanInviteMembers ?? false,
                //   settings?.anyoneCanUpdatePhotosVideos ?? false,
                //   value,
                // );
              },
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () =>
                _handleEditTap(context, EditableGroupCardType.settings),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorPalette.primary,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                Assets.icons.edit.path,
                height: 16,
                width: 16,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleEditTap(
    BuildContext context,
    EditableGroupCardType editType, {
    bool isNeedToAddPrompt = false,
  }) {
    log('Edit tapped for type: $editType');

    switch (editType) {
      case EditableGroupCardType.image:
        AutoRouter.of(context).push(CreateGroupGalleryRoute(isEditMode: true));
        break;
      case EditableGroupCardType.title:
        _showTitleEditDialog(context);
        break;
      case EditableGroupCardType.bio:
        _showBioEditDialog(context);
        break;
      case EditableGroupCardType.category:
        _showCategoryEditDialog(context);
        break;
      case EditableGroupCardType.settings:
        AutoRouter.of(context).push(CreateGroupRoute(isEditMode: true));
        break;
      case EditableGroupCardType.prompt:
        AutoRouter.of(context)
            .push(
              KycPromptRoute(
                showSkipButton: false,
                isEditMode: !isNeedToAddPrompt,
                title: "Edit Group Prompts",
              ),
            )
            .then((_) {
              if (mounted) {
                _myGroupCubit.fetchGroupById(widget.groupId);
              }
            });
        break;
    }
  }

  void _showTitleEditDialog(BuildContext context) {
    final controller = TextEditingController(text: _titleController.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isLightTheme(context)
            ? Colors.white
            : Color(0xFF0B0B0B),
        title: Text(
          'Edit Group Name',
          style: AppTextStyles.h3(context).copyWith(
            color: isLightTheme(context) ? Colors.black : Colors.white,
          ),
        ),
        content: TextField(
          controller: controller,
          style: AppTextStyles.body(context).copyWith(
            color: isLightTheme(context) ? Colors.black : Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter group name',
            hintStyle: AppTextStyles.body(context).copyWith(
              color: isLightTheme(context) ? Colors.black38 : Colors.white38,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _titleController.text = controller.text;
              _updateGroupData();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showBioEditDialog(BuildContext context) {
    final controller = TextEditingController(text: _bioController.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isLightTheme(context)
            ? Colors.white
            : Color(0xFF0B0B0B),
        title: Text(
          'Edit Bio',
          style: AppTextStyles.h3(context).copyWith(
            color: isLightTheme(context) ? Colors.black : Colors.white,
          ),
        ),
        content: TextField(
          controller: controller,
          style: AppTextStyles.body(context).copyWith(
            color: isLightTheme(context) ? Colors.black : Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter group bio',
            hintStyle: AppTextStyles.body(context).copyWith(
              color: isLightTheme(context) ? Colors.black38 : Colors.white38,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          maxLines: 4,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _bioController.text = controller.text;
              _updateGroupData();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showCategoryEditDialog(BuildContext context) {
    final controller = TextEditingController(text: _categoryController.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isLightTheme(context)
            ? Colors.white
            : Color(0xFF0B0B0B),
        title: Text(
          'Edit Category',
          style: AppTextStyles.h3(context).copyWith(
            color: isLightTheme(context) ? Colors.black : Colors.white,
          ),
        ),
        content: TextField(
          controller: controller,
          style: AppTextStyles.body(context).copyWith(
            color: isLightTheme(context) ? Colors.black : Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'e.g., Travel & Adventure',
            hintStyle: AppTextStyles.body(context).copyWith(
              color: isLightTheme(context) ? Colors.black38 : Colors.white38,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _categoryController.text = controller.text;
              _updateGroupData();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _updateGroupData() {
    final body = {
      'title': _titleController.text,
      'bio': _bioController.text,
      'fitsForGroup': _categoryController.text,
      'groupSettings': _myGroupCubit.myGroupModel?.data?.groupSettings
          ?.toJson(),
      'photosVideos': _myGroupCubit.myGroupModel?.data?.photosVideos ?? [],
      'members': _myGroupCubit.myGroupModel?.data?.members?.toList() ?? [],
    };

    _myGroupCubit.updateGroupById(widget.groupId, body);
    log('Group updated with data: $body');
  }

  void _updateGroupSettings(
    bool anyoneCanInvite,
    bool anyoneCanUpdatePhotos,
    bool anyoneCanUpdatePrompts,
  ) {
    final body = {
      'title': _titleController.text,
      'bio': _bioController.text,
      'fitsForGroup': _categoryController.text,
      'groupSettings': {
        'anyoneCanInviteMembers': anyoneCanInvite,
        'anyoneCanUpdatePhotosVideos': anyoneCanUpdatePhotos,
        'anyoneCanUpdatePrompts': anyoneCanUpdatePrompts,
      },
      'photosVideos': _myGroupCubit.myGroupModel?.data?.photosVideos ?? [],
      'members': _myGroupCubit.myGroupModel?.data?.members?.toList() ?? [],
    };

    _myGroupCubit.updateGroupById(widget.groupId, body);
    log('Group settings updated: $body');
  }
}
