import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:fennac_app/pages/chats/data/repository/chat_repository.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/call_history_item.dart';
import 'package:fennac_app/reusable_widgets/horizontal_avatar_list.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_search_field.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:lottie/lottie.dart';

import '../../../../bloc/cubit/imagepicker_cubit.dart';

class SubscribedChatWidget extends StatefulWidget {
  const SubscribedChatWidget({super.key});

  @override
  State<SubscribedChatWidget> createState() => _SubscribedChatWidgetState();
}

class _SubscribedChatWidgetState extends State<SubscribedChatWidget> {
  int? _tappedIndex;
  bool _isCheckingPokeAccess = false;

  @override
  Widget build(BuildContext context) {
    final chatLandingCubit = Di().sl<ChatLandingCubit>();

    return BlocBuilder<ChatLandingCubit, ChatLandingState>(
      bloc: chatLandingCubit,
      builder: (context, state) {
        if (state.isLoadingData && state.chats.isEmpty) {
          return Center(child: Lottie.asset(Assets.animations.loadingSpinner));
        }
        if (state.errorMessage != null && state.chats.isEmpty) {
          return Center(child: Text(state.errorMessage!));
        }

        final chats = state.chats;
        final activeChats = chatLandingCubit.isSearching
            ? chatLandingCubit.filteredChats
            : chats;
        final members = state.members;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSizedBox(height: 12),
              CustomSearchField(
                hintText: 'Search',
                onChanged: (query) {
                  setState(() => _tappedIndex = null);
                  chatLandingCubit.onSearchChanged(query);
                },
              ),
              const CustomSizedBox(height: 16),
              if (members.isNotEmpty)
                HorizontalAvatarList(
                  members: members,
                  onAvatarTap: (member) {
                    Di().sl<ImagePickerCubit>().clearAllMedia();
                    log('Tapped member: ${member.name} (${member.id})');

                    final chat = chats.firstWhere(
                      (c) => c.members?.any((m) => m.id == member.id) ?? false,
                      orElse: () => chats.first,
                    );

                    log('Chat ID: ${chat.id}');
                    log('OtherUserId: ${chat.meta.directChat?.otherUserId}');
                    log('Chat Type: ${chat.type}');

                    final isOnline = chat.status.toLowerCase() == 'online';

                    context.router.push(
                      GroupChatRoute(
                        isGroup: chat.type == 'group' ? true : false,
                        groupId: _resolveChatRouteId(chat),
                        contactAvatar: member.image,
                        contactName: member.name,
                        isOnline: isOnline,
                        otherGroupId: chat.type == 'group'
                            ? (chat.meta.receiverGroupId ??
                                  chat
                                      .meta
                                      .groupsDetails
                                      ?.matchedGroupMembers
                                      .firstOrNull
                                      ?.groupId)
                            : null,
                      ),
                    );
                  },
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Your Groups',
                  style: AppTextStyles.subHeading(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const CustomSizedBox(height: 16),
              if (chatLandingCubit.isSearching && activeChats.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Text(
                    'No chats found',
                    style: AppTextStyles.description(context),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: activeChats.length,
                  itemBuilder: (context, index) {
                    final chat = activeChats[index];

                    final isHighlighted = _tappedIndex == index;
                    final isGroup = chat.type == 'group';
                    final isOnline = chat.status.toLowerCase() == 'online';

                    return GestureDetector(
                      onTap: () async {
                        Di().sl<ImagePickerCubit>().clearAllMedia();

                        if (chat.type == 'poke') {
                          final pokeId = _resolvePokeId(chat);

                          if ((pokeId == null || pokeId.isEmpty) &&
                              chat.meta.hasStartedChat &&
                              (chat.meta.directChat?.otherUserId?.isNotEmpty ??
                                  false)) {
                            context.router.push(
                              GroupChatRoute(
                                isGroup: false,
                                groupId: chat.meta.directChat!.otherUserId!,
                                contactAvatar: chat.image,
                                contactName: chat.name,
                                isOnline: isOnline,
                                otherGroupId: chat.type == 'group'
                                    ? (chat.meta.receiverGroupId ??
                                          chat
                                              .meta
                                              .groupsDetails
                                              ?.matchedGroupMembers
                                              .firstOrNull
                                              ?.groupId)
                                    : null,
                              ),
                            );
                            return;
                          }
                          // if (chat.pokes.isNotEmpty &&
                          //     chat.pokes.first.status?.toLowerCase() ==
                          //         'started_chat') {
                          //   final otherUserId =
                          //       chat.meta.directChat?.otherUserId;
                          //   context.router.push(
                          //     GroupChatRoute(
                          //       isGroup: false,
                          //       groupId: otherUserId?.isNotEmpty == true
                          //           ? otherUserId!
                          //           : chat.id,
                          //       contactAvatar: chat.image,
                          //       contactName: chat.name,
                          //       isOnline: isOnline,
                          //       otherGroupId: chat.type == 'group'
                          //           ? (chat.meta.receiverGroupId ??
                          //                 chat
                          //                     .meta
                          //                     .groupsDetails
                          //                     ?.matchedGroupMembers
                          //                     .firstOrNull
                          //                     ?.groupId)
                          //           : null,
                          //     ),
                          //   );
                          //   return;
                          // }
                          await _openPokeDetailIfAllowed(context, pokeId);
                          return;
                        }

                        context.router.push(
                          GroupChatRoute(
                            isGroup: isGroup,
                            groupId: _resolveChatRouteId(chat),
                            contactAvatar: chat.image,
                            contactName: chat.name,
                            isOnline: isOnline,
                            otherGroupId: chat.type == 'group'
                                ? (chat.meta.receiverGroupId ??
                                      chat
                                          .meta
                                          .groupsDetails
                                          ?.matchedGroupMembers
                                          .firstOrNull
                                          ?.groupId)
                                : null,
                          ),
                        );
                      },
                      onTapDown: (_) {
                        setState(() {
                          _tappedIndex = index;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _tappedIndex = null;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _tappedIndex = null;
                        });
                      },
                      child: Container(
                        color: isHighlighted
                            ? ColorPalette.primary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        child: CallHistoryItem(
                          name: isGroup ? null : chat.name,
                          names: isGroup ? _resolveGroupNames(chat) : null,
                          isGroup: isGroup,
                          avatar: chat.image,
                          avatars: isGroup
                              ? _resolveGroupAvatars(chat)
                              : chat.members?.map((m) => m.image).toList(),
                          unreadCount: chat.unreadCount,
                          timeAgo: chat.lastMessageAt != null
                              ? _getTimeAgo(chat.lastMessageAt!)
                              : '',
                          isPoked: chat.type == 'poke',
                          lastMessage: chat.lastMessage,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          showBorder: index != activeChats.length - 1,
                          backgroundColor: isHighlighted
                              ? ColorPalette.primary.withValues(alpha: 0.15)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              CustomSizedBox(
                height: MediaQuery.paddingOf(context).bottom + 100,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openPokeDetailIfAllowed(
    BuildContext context,
    String? pokeId,
  ) async {
    if (_isCheckingPokeAccess) return;

    if (pokeId == null || pokeId.isEmpty) {
      VxToast.show(message: 'Poke details are unavailable right now.');
      return;
    }

    _isCheckingPokeAccess = true;
    try {
      final response = await Di().sl<ChatRepository>().getPokeDetail(pokeId);
      if (!context.mounted) return;

      if (response.success) {
        context.router.push(GetPockedRoute(pokeId: pokeId));
      } else {
        VxToast.show(message: response.message);
      }
    } catch (e) {
      if (!context.mounted) return;
      final message = e.toString().replaceFirst('Exception: ', '').trim();
      VxToast.show(
        message: message.isNotEmpty ? message : 'Unable to open poke details.',
      );
    } finally {
      _isCheckingPokeAccess = false;
    }
  }

  String? _resolvePokeId(ChatModel chat) {
    final fromMeta = chat.meta.latestPoke?.pokeId;
    if (fromMeta != null && fromMeta.isNotEmpty) return fromMeta;

    final fromMetaId = chat.meta.latestPoke?.id;
    if (fromMetaId != null && fromMetaId.isNotEmpty) return fromMetaId;

    // if (chat.pokes.isNotEmpty) {
    //   final fromPokes = chat.pokes.first.id;
    //   if (fromPokes.isNotEmpty) return fromPokes;
    // }

    return null;
  }

  List<String> _resolveGroupNames(ChatModel chat) {
    final groupTitle = chat.name.trim();
    if (groupTitle.isNotEmpty) {
      return [groupTitle];
    }

    final matchedMembers =
        chat.meta.groupsDetails?.matchedGroupMembers ??
        const <MatchedGroupMembersModel>[];

    final names = matchedMembers
        .expand((group) => group.members)
        .map(
          (member) =>
              '${member.firstName ?? ''} ${member.lastName ?? ''}'.trim(),
        )
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList();

    if (names.isNotEmpty) {
      return names;
    }

    final memberNames = (chat.members ?? const <MemberModel>[])
        .map((member) => member.name.trim())
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList();

    if (memberNames.isNotEmpty) {
      return memberNames;
    }

    return [chat.name];
  }

  List<String> _resolveGroupAvatars(ChatModel chat) {
    final matchedMembers =
        chat.meta.groupsDetails?.matchedGroupMembers ??
        const <MatchedGroupMembersModel>[];

    final matchedAvatars = matchedMembers
        .expand((group) => group.members)
        .map((member) => (member.image ?? '').trim())
        .where((image) => image.isNotEmpty)
        .toSet()
        .toList();

    if (matchedAvatars.isNotEmpty) {
      return matchedAvatars;
    }

    final memberAvatars = (chat.members ?? const <MemberModel>[])
        .map((member) => member.image.trim())
        .where((image) => image.isNotEmpty)
        .toSet()
        .toList();

    if (memberAvatars.isNotEmpty) {
      return memberAvatars;
    }

    return chat.image.trim().isNotEmpty ? [chat.image] : <String>[];
  }

  String _resolveChatRouteId(ChatModel chat) {
    final directUserId = chat.meta.directChat?.otherUserId;
    if (chat.type != 'group' && directUserId?.isNotEmpty == true) {
      return directUserId!;
    }

    return chat.id;
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }
}
