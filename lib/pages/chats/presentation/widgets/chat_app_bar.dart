import 'dart:developer';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/call/presentation/bloc/cubit/call_cubit.dart';
import 'package:fennac_app/pages/call/presentation/bloc/state/call_state.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/reusable_widgets/circle_icon_button.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class ChatAppBar extends StatelessWidget {
  final bool isGroup;
  final String? contactName;
  final String? contactAvatar;
  final bool isOnline;
  final String? chatId;

  const ChatAppBar({
    super.key,
    required this.isGroup,
    this.contactName,
    this.contactAvatar,
    this.isOnline = false,
    this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return isGroup
        ? _buildGroupHeader(context)
        : _buildIndividualHeader(context);
  }

  Widget _buildGroupHeader(BuildContext context) {
    final isLight = isLightTheme(context);
    final currentChat = Di()
        .sl<ChatLandingCubit>()
        .state
        .chats
        .where((c) => c.id == chatId)
        .firstOrNull;
    final members = currentChat?.members ?? [];
    final displayMembers = members.length > 9 ? members.sublist(0, 9) : members;
    final group = Group(
      id: currentChat?.id ?? chatId,
      name: currentChat?.name,
      coverImage: currentChat?.image,
      members: (currentChat?.members ?? [])
          .map(
            (m) => Member(
              id: m.id,
              name: m.name,
              firstName: m.name,
              coverImage: m.image,
            ),
          )
          .toList(),
    );

    final topPadding = MediaQuery.of(context).padding.top;
    final headerContent = Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: topPadding + 12,
        bottom: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackButton(height: 40, width: 40),
          const CustomSizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.router.push(
                  GroupDetailRoute(
                    isGroup: true,
                    contactName: currentChat?.name ?? contactName,
                    contactAvatar: currentChat?.image ?? contactAvatar,
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatars Stack
                  SizedBox(
                    width: 210,
                    height: 24,
                    child: Stack(
                      children: List.generate(displayMembers.length, (index) {
                        final imageUrl = displayMembers[index].image;
                        return Positioned(
                          left: index * 14.0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorPalette.secondary,
                                width: 2,
                              ),
                              image: imageUrl.isNotEmpty
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        imageUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              color: Colors.black26,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const CustomSizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${members.length} member${members.length == 1 ? '' : 's'}',
                        style: AppTextStyles.bodySmall(
                          context,
                        ).copyWith(fontWeight: FontWeight.w400),
                      ),
                      const CustomSizedBox(width: 2),
                      Icon(
                        Icons.chevron_right,
                        color: isLight ? ColorPalette.black : Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<CallCubit, CallState>(
            bloc: Di().sl<CallCubit>(),
            builder: (context, state) {
              final callCubit = Di().sl<CallCubit>();
              final isStartingCall = callCubit.isStartingCall;
              final isStartingAudioCall = callCubit.isStartingAudioCall;
              final isStartingVideoCall = callCubit.isStartingVideoCall;

              return Row(
                children: [
                  CircleIconButton(
                    customChild: isStartingAudioCall
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: Lottie.asset(
                              Assets.animations.loadingSpinner,
                              fit: BoxFit.cover,
                            ),
                          )
                        : SvgPicture.asset(
                            Assets.icons.phone.path,
                            colorFilter: ColorFilter.mode(
                              isLightTheme(context)
                                  ? ColorPalette.black
                                  : Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 20,
                            height: 20,
                          ),
                    onTap: isStartingCall
                        ? null
                        : () {
                            _startCallFromHeader(
                              context,
                              isVideoCall: false,
                              isGroup: isGroup,
                              group: group,
                            );
                          },
                  ),
                  const CustomSizedBox(width: 8),
                  CircleIconButton(
                    customChild: isStartingVideoCall
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: Lottie.asset(
                              Assets.animations.loadingSpinner,
                              fit: BoxFit.cover,
                            ),
                          )
                        : SvgPicture.asset(
                            Assets.icons.video.path,
                            colorFilter: ColorFilter.mode(
                              isLightTheme(context)
                                  ? ColorPalette.black
                                  : Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 20,
                            height: 20,
                          ),
                    onTap: isStartingCall
                        ? null
                        : () {
                            _startCallFromHeader(
                              context,
                              isVideoCall: true,
                              isGroup: isGroup,
                              group: group,
                            );
                          },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    if (isLight) {
      return Container(color: Colors.white, child: headerContent);
    }

    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 40,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Positioned(
          //   top: 40,
          //   left: 0,
          //   right: 0,
          //   height: 0,
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          //     child: Container(color: Colors.transparent),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF111111).withValues(alpha: 0.5),
                  const Color(0xFF111111).withValues(alpha: 0),
                ],
              ),
            ),
          ),
          // Content
          headerContent,
        ],
      ),
    );
  }

  Widget _buildIndividualHeader(BuildContext context) {
    final isLight = isLightTheme(context);
    final topPadding = MediaQuery.of(context).padding.top;
    final headerContent = Padding(
      padding: EdgeInsets.only(
        left: 6,
        right: 6,
        top: topPadding + 12,
        bottom: 12,
      ),
      child: Row(
        children: [
          CustomBackButton(height: 40, width: 40),
          const CustomSizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: contactAvatar != null
                        ? DecorationImage(
                            image: NetworkImage(contactAvatar!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
                const CustomSizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        contactName ?? 'Unknown',
                        style: AppTextStyles.body(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                      const CustomSizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isOnline ? Colors.green : Colors.grey,
                            ),
                          ),
                          const CustomSizedBox(width: 6),
                          Text(
                            textAlign: TextAlign.start,
                            isOnline ? 'Online' : 'Offline',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: isLightTheme(context)
                                  ? ColorPalette.black
                                  : Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomSizedBox(width: 12),
          BlocBuilder<CallCubit, CallState>(
            bloc: Di().sl<CallCubit>(),
            builder: (context, state) {
              final callCubit = Di().sl<CallCubit>();
              final isStartingCall = callCubit.isStartingCall;
              final isStartingAudioCall = callCubit.isStartingAudioCall;
              final isStartingVideoCall = callCubit.isStartingVideoCall;

              return Row(
                children: [
                  CircleIconButton(
                    customChild: isStartingAudioCall
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: Lottie.asset(
                              Assets.animations.loadingSpinner,
                            ),
                          )
                        : SvgPicture.asset(
                            Assets.icons.phone.path,
                            colorFilter: ColorFilter.mode(
                              isLightTheme(context)
                                  ? ColorPalette.black
                                  : Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 20,
                            height: 20,
                          ),
                    onTap: isStartingCall
                        ? null
                        : () => _startCallFromHeader(
                            context,
                            isVideoCall: false,
                            isGroup: isGroup,
                          ),
                  ),
                  const CustomSizedBox(width: 8),
                  CircleIconButton(
                    customChild: isStartingVideoCall
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: Lottie.asset(
                              Assets.animations.loadingSpinner,
                            ),
                          )
                        : SvgPicture.asset(
                            Assets.icons.video.path,
                            colorFilter: ColorFilter.mode(
                              isLightTheme(context)
                                  ? ColorPalette.black
                                  : Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 20,
                            height: 20,
                          ),
                    onTap: isStartingCall
                        ? null
                        : () => _startCallFromHeader(
                            context,
                            isVideoCall: true,
                            isGroup: isGroup,
                          ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    if (isLight) {
      return Container(color: Colors.white, child: headerContent);
    }

    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Stack(
        children: [
          // Gradient blur layers - strong at top, fading to almost 0 at bottom
          // Top section - full blur (24)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 40,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(color: Colors.transparent),
            ),
          ),
          // Middle-top section - medium blur (18)
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            height: 20,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(color: Colors.transparent),
            ),
          ),
          // Middle section - lighter blur (12)
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            height: 20,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.transparent),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF111111).withValues(alpha: 0.5),
                  const Color(0xFF111111).withValues(alpha: 0),
                ],
              ),
            ),
          ),
          // Content
          headerContent,
        ],
      ),
    );
  }

  Future<void> _startCallFromHeader(
    BuildContext context, {
    required bool isVideoCall,
    bool isGroup = false,
    Group? group,
  }) async {
    final callCubit = Di().sl<CallCubit>();
    final participantId = _resolveParticipantId();
    log("ids $participantId");
    if (participantId == null || participantId.isEmpty) {
      return;
    }

    final response = await callCubit.startCall(
      mediaType: isVideoCall ? 'video' : 'audio',
      callType: isGroup ? 'group' : 'individual',
      participantIds: participantId,
      callerImageUrl: contactAvatar,
    );

    if (!context.mounted || response == null) return;

    // if (isGroup && group != null) {
    //   AutoRouter.of(
    //     context,
    //   ).push(GroupAudioCallRoute(group: group, isVideoCall: isVideoCall));
    //   return;
    // }

    // if (isVideoCall) {
    //   AutoRouter.of(context).push(VideoCallRoute());
    // } else {
    AutoRouter.of(context).push(AudioCallRoute());
    // }
  }

  List<String>? _resolveParticipantId() {
    List<String> participantIds = [];
    final targetChatId = chatId;
    if (targetChatId == null || targetChatId.isEmpty) return null;

    final currentUserId = Di().sl<LoginCubit>().userData?.user?.id;
    final chats = Di().sl<ChatLandingCubit>().state.chats;

    for (final chat in chats) {
      if (chat.id != targetChatId) continue;

      final members = chat.members;
      final otherGroupMembers = chat.matchedGroupDetails?.members;
      if (members != null && members.isNotEmpty) {
        participantIds.addAll(
          members.map((m) => m.id).where((id) => id != currentUserId),
        );
      }
      if (otherGroupMembers != null && otherGroupMembers.isNotEmpty) {
        participantIds.addAll(
          otherGroupMembers.map((m) => m.id).where((id) => id != currentUserId),
        );
      }

      participantIds = participantIds.toSet().toList();
    }

    return participantIds;
  }
}
