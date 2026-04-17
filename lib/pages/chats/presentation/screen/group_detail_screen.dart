import 'dart:developer';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/cached_network_image_helper.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/group_details_tab_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/group_details_tab_state.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/group_detail_members_avatar.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/group_detail_widget.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/state/my_group_state.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/full_profile_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class GroupDetailScreen extends StatefulWidget {
  final bool isGroup;
  final String? contactName;
  final String? contactAvatar;
  final bool isOnline;

  const GroupDetailScreen({
    super.key,
    this.isGroup = true,
    this.contactName,
    this.contactAvatar,
    this.isOnline = false,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final ValueNotifier<bool> _blurNotifier = ValueNotifier(false);
  final TextEditingController _nameController = TextEditingController(
    text: 'Weekend Warriors',
  );

  late final MyGroupCubit _myGroupCubit;
  late final ChatLandingCubit _chatLandingCubit;
  late final GroupDetailsTabCubit _groupDetailsTabCubit;

  @override
  void initState() {
    super.initState();
    _myGroupCubit = Di().sl<MyGroupCubit>();
    _chatLandingCubit = Di().sl<ChatLandingCubit>();
    _groupDetailsTabCubit = GroupDetailsTabCubit();
    if ((widget.contactName ?? '').isNotEmpty) {
      _nameController.text = widget.contactName!;
    }
  }

  @override
  void dispose() {
    _blurNotifier.dispose();
    _nameController.dispose();
    _groupDetailsTabCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.secondary,
      body: Stack(
        children: [
          MovableBackground(
            backgroundType: MovableBackgroundType.dark,
            child: SafeArea(
              child: ValueListenableBuilder<bool>(
                valueListenable: _blurNotifier,
                builder: (context, isBlurred, child) {
                  return Stack(
                    children: [
                      child!,
                      if (isBlurred)
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.35),
                            ),
                          ),
                        ),
                    ],
                  );
                },
                child: _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final currentChat = _resolveCurrentGroupChat();
    final groupData = _resolveGroupData(currentChat);
    final displayName =
        groupData?.titleMembers ?? currentChat?.name ?? widget.contactName;
    if ((displayName ?? '').isNotEmpty &&
        (_nameController.text == 'Weekend Warriors' ||
            _nameController.text.isEmpty)) {
      _nameController.text = displayName!;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(title: 'Group Details'),
          const CustomSizedBox(height: 16),
          BlocBuilder<MyGroupCubit, MyGroupState>(
            bloc: _myGroupCubit,
            builder: (context, _) {
              final groupsDetails = currentChat?.meta.groupsDetails;

              final userGroupMembers =
                  (groupsDetails?.userGroupMembers ?? const [])
                      .map(_mapChatGroupMemberToMemberModel)
                      .toList();

              final matchedGroupMembers =
                  (groupsDetails?.matchedGroupMembers ?? const [])
                      .expand((group) => group.members)
                      .map(_mapChatGroupMemberToMemberModel)
                      .toList();

              final rawMembers = groupData?.members ?? [];
              final fallbackMembers = rawMembers
                  .map(
                    (m) => MemberModel(
                      id: m.id ?? '',
                      name: [
                        m.firstName ?? '',
                        m.lastName ?? '',
                      ].where((s) => s.isNotEmpty).join(' ').trim(),
                      image: m.image ?? '',
                    ),
                  )
                  .toList();

              if (fallbackMembers.isEmpty && currentChat?.members != null) {
                fallbackMembers.addAll(currentChat!.members!);
              }

              if (userGroupMembers.isEmpty && matchedGroupMembers.isEmpty) {
                return GroupDetailMembersAvatar(
                  members: fallbackMembers,
                  onTap: (member) {
                    FullProfileDialog().showProfile(
                      memberId: member.id,
                      context: context,
                    );
                  },
                );
              }

              return Column(
                children: [
                  if (userGroupMembers.isNotEmpty)
                    GroupDetailMembersAvatar(
                      members: userGroupMembers,
                      onTap: (member) {
                        FullProfileDialog().showProfile(
                          memberId: member.id,
                          context: context,
                        );
                      },
                    ),
                  Container(
                    width: 408,
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: const [
                          Color.fromRGBO(95, 0, 219, 0.0),
                          Colors.white,
                          Color.fromRGBO(95, 0, 219, 0.0),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  if (userGroupMembers.isNotEmpty &&
                      matchedGroupMembers.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(height: 8, color: Color(0x40FFFFFF)),
                    ),
                  if (matchedGroupMembers.isNotEmpty)
                    GroupDetailMembersAvatar(
                      members: matchedGroupMembers,
                      onTap: (member) async {
                        FullProfileDialog().showProfile(
                          memberId: member.id,
                          context: context,
                        );
                      },
                    ),
                ],
              );
            },
          ),
          CustomLabelTextField(
            controller: _nameController,
            hintText: 'Enter group name',
            textStyle: AppTextStyles.h4(
              context,
            ).copyWith(fontWeight: FontWeight.w700),
            filled: false,
            isCentered: true,

            suffix: SvgPicture.asset(
              Assets.icons.edit3.path,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                isLightTheme(context)
                    ? ColorPalette.black
                    : ColorPalette.textSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const CustomSizedBox(height: 20),
          GroupDetailWidget(
            title1: 'About This Group',
            title2: 'Shared Media',
            tabCubit: _groupDetailsTabCubit,
          ),
          const CustomSizedBox(height: 20),
          BlocBuilder<GroupDetailsTabCubit, GroupDetailsTabState>(
            bloc: _groupDetailsTabCubit,
            builder: (context, state) {
              final selectedTab = state.selectedTab;
              return selectedTab == 0
                  ? _buildAboutThisGroupContent(
                      context,
                      groupData: groupData,
                      currentChat: currentChat,
                    )
                  : BlocBuilder<MessageCubit, MessageState>(
                      bloc: Di().sl<MessageCubit>(),
                      builder: (context, _) {
                        final previewMessages = Di()
                            .sl<MessageCubit>()
                            .messages;
                        final mediaUrls = _resolveMessageAttachmentMediaUrls(
                          previewMessages,
                        );

                        return _buildSharedMediaContent(
                          context,
                          mediaUrls: mediaUrls,
                          previewMessages: previewMessages,
                        );
                      },
                    );
            },
          ),
          const CustomSizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMatchedCard(
    BuildContext context, {
    required int memberCount,
    required int matchedMonthsAgo,
    required List<String> interests,
  }) {
    return Container(
      height: 273,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLightTheme(context)
            ? ColorPalette.textGrey
            : ColorPalette.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  Assets.animations.iconBg,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Matched',
                        style: AppTextStyles.description(context),
                      ),
                      Text('$memberCount', style: AppTextStyles.h1(context)),
                      Text(
                        '$matchedMonthsAgo month${matchedMonthsAgo == 1 ? '' : 's'} ago',
                        style: AppTextStyles.description(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomSizedBox(height: 16),
          Text(
            'Common Interests',
            style: AppTextStyles.label(
              context,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          const CustomSizedBox(height: 8),

          _buildInterests(context, interests),
        ],
      ),
    );
  }

  Widget _buildAboutThisGroupContent(
    BuildContext context, {
    required MyGroupData? groupData,
    required ChatModel? currentChat,
  }) {
    final memberCount =
        groupData?.members?.length ?? currentChat?.members?.length ?? 0;
    final matchedMonthsAgo = _calculateMatchedMonths(groupData?.createdAt);
    final interests = _resolveInterests(groupData);

    return Column(
      children: [
        _buildMatchedCard(
          context,
          memberCount: memberCount,
          matchedMonthsAgo: matchedMonthsAgo,
          interests: interests,
        ),
        const CustomSizedBox(height: 32),
        _buildUnmatchButton(context, groupData: groupData),
      ],
    );
  }

  Widget _buildSharedMediaContent(
    BuildContext context, {
    required List<String> mediaUrls,
    required List<MessageModel> previewMessages,
  }) {
    if (mediaUrls.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'No shared media available',
          style: AppTextStyles.description(context),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: mediaUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            AutoRouter.of(context).push(
              MediaPreviewRoute(messages: previewMessages, initialIndex: index),
            );
          },
          child: _buildMediaItem(mediaUrls[index]),
        );
      },
    );
  }

  Widget _buildMediaItem(String mediaUrl) {
    final isVideo =
        mediaUrl.toLowerCase().endsWith('.mp4') ||
        mediaUrl.toLowerCase().endsWith('.mov') ||
        mediaUrl.toLowerCase().endsWith('.mkv') ||
        mediaUrl.toLowerCase().endsWith('.webm');

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Media thumbnail
          CachedImageHelper(
            imageUrl: mediaUrl,
            fit: BoxFit.cover,
            errorWidget: Container(
              color: ColorPalette.black.withValues(alpha: 0.5),
              child: const Icon(Icons.image, color: Colors.white, size: 40),
            ),
          ),

          // Play button overlay for videos
          if (isVideo)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInterests(BuildContext context, List<String> interests) {
    if (interests.isEmpty) {
      return Text(
        'No interests added yet',
        style: AppTextStyles.description(context),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: interests.map((interest) {
        // Split emoji and text
        final parts = interest.split(' ');
        final emoji = parts.isNotEmpty ? parts[0] : '';
        final text = parts.length > 1 ? parts.sublist(1).join(' ') : interest;

        return ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: isLightTheme(context)
                    ? ColorPalette.textGrey
                    : ColorPalette.primary,
                border: Border.all(
                  color: isLightTheme(context)
                      ? ColorPalette.primary
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(48),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 14)),
                  const CustomSizedBox(width: 6),
                  Text(
                    text,
                    style: AppTextStyles.bodySmall(
                      context,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  ChatModel? _resolveCurrentGroupChat() {
    final chats = _chatLandingCubit.state.chats;
    final contactName = (widget.contactName ?? '').trim();
    final contactAvatar = (widget.contactAvatar ?? '').trim();

    for (final chat in chats) {
      if (chat.type != 'group') continue;
      if (contactName.isNotEmpty && chat.name == contactName) return chat;
      if (contactAvatar.isNotEmpty && chat.image == contactAvatar) return chat;
    }

    for (final chat in chats) {
      if (chat.type == 'group') return chat;
    }

    return null;
  }

  MyGroupData? _resolveGroupData(ChatModel? currentChat) {
    final groups =
        _myGroupCubit.myGroupList?.groupList ?? const <MyGroupData>[];
    final targetName = (currentChat?.name ?? widget.contactName ?? '').trim();

    for (final group in groups) {
      if ((group.titleMembers ?? '').trim() == targetName) {
        return group;
      }
    }

    return _myGroupCubit.myGroupModel?.data;
  }

  List<String> _resolveInterests(MyGroupData? groupData) {
    final fits = (groupData?.fitsForGroup ?? '').trim();
    if (fits.isEmpty) return const [];

    return fits
        .split(RegExp(r'[,|]'))
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList();
  }

  MemberModel _mapChatGroupMemberToMemberModel(ChatGroupMemberUserModel m) {
    final fullName = [
      m.firstName ?? '',
      m.lastName ?? '',
    ].where((s) => s.trim().isNotEmpty).join(' ').trim();

    return MemberModel(
      id: m.id,
      name: fullName.isEmpty ? 'Member' : fullName,
      image: m.image ?? '',
    );
  }

  List<String> _resolveMessageAttachmentMediaUrls(
    List<MessageModel> sourceMessages,
  ) {
    return sourceMessages
        .where(
          (message) =>
              message.type == MessageType.image ||
              message.type == MessageType.video,
        )
        .expand((message) {
          if (message.imageUrls.isNotEmpty) {
            return message.imageUrls;
          }

          final mediaUrl = message.mediaUrl;
          if (mediaUrl != null && mediaUrl.trim().isNotEmpty) {
            return [mediaUrl];
          }

          return const <String>[];
        })
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList();
  }

  int _calculateMatchedMonths(DateTime? createdAt) {
    if (createdAt == null) return 0;
    final difference = DateTime.now().difference(createdAt);
    final months = (difference.inDays / 30).floor();
    return months < 0 ? 0 : months;
  }

  Widget _buildUnmatchButton(BuildContext context, {MyGroupData? groupData}) {
    return GestureDetector(
      onTap: () {
        CustomBottomSheet.show(
          icon: AnimatedBackgroundContainer(
            icon: Assets.icons.alertTriangle.path,
          ),
          context: context,
          title: 'Unmatch this Group?',
          description:
              'By unmatching it will unmatch the entire group not just you. You’ll lose access to your chat and shared media with this group. They won’t be notified, but they’ll no longer see your group in their matches.',
          buttonText: 'Dismiss',
          secondaryButtonText: 'Unmatch',
          onButtonPressed: () {},
          onSecondaryButtonPressed: () async {
            final bool isUnmatched = await Di().sl<MyGroupCubit>().unMatchGroup(
              groupData?.id ?? '',
            );
            if (!context.mounted || !isUnmatched) return;
            Navigator.of(context).pop();
            CustomBottomSheet.show(
              icon: AnimatedBackgroundContainer(
                icon: Assets.icons.heartBroken.path,
                isPng: true,
                iconHeight: 56,
                iconWidth: 56,
              ),
              context: context,
              title: 'You’ve Unmatched This Group',
              description:
                  'We’ve closed your chat and removed this group from your matches. You can still find new connections.',
              buttonText: 'Explore Groups',
              dismissible: false,
              onButtonPressed: () {
                AutoRouter.of(context).push(DashboardRoute());
                Di().sl<DashboardCubit>().changeIndex(0);
              },
            );
          },
          blurNotifier: _blurNotifier,
          isHorizontalButton: true,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: isLightTheme(context)
              ? ColorPalette.textGrey
              : ColorPalette.black.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLightTheme(context)
                ? ColorPalette.textGrey
                : ColorPalette.black.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Unmatch Group',
              style: AppTextStyles.body(
                context,
              ).copyWith(color: Colors.redAccent, fontWeight: FontWeight.w700),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.redAccent, size: 20),
          ],
        ),
      ),
    );
  }
}
