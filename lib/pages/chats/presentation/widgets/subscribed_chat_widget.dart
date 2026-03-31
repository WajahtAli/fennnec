import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
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
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null && state.chats.isEmpty) {
          return Center(child: Text(state.errorMessage!));
        }

        final chats = state.chats;
        final activeChats = chatLandingCubit.isSearching
            ? chatLandingCubit.filteredChats
            : chats;
        final members = activeChats
            .expand((chat) => chat.members ?? <MemberModel>[])
            .fold<Map<String, MemberModel>>({}, (map, member) {
              if (!map.containsKey(member.id)) {
                map[member.id] = member;
              }
              return map;
            })
            .values
            .toList();

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
              if (members.isNotEmpty) HorizontalAvatarList(members: members),
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
                              ),
                            );
                            return;
                          }
                          if (chat.pokes.isNotEmpty &&
                              chat.pokes.first.status?.toLowerCase() ==
                                  'started_chat') {
                            final otherUserId =
                                chat.meta.directChat?.otherUserId;
                            context.router.push(
                              GroupChatRoute(
                                isGroup: false,
                                groupId: otherUserId?.isNotEmpty == true
                                    ? otherUserId!
                                    : chat.id,
                                contactAvatar: chat.image,
                                contactName: chat.name,
                                isOnline: isOnline,
                              ),
                            );
                            return;
                          }
                          await _openPokeDetailIfAllowed(context, pokeId);
                          return;
                        }

                        context.router.push(
                          GroupChatRoute(
                            isGroup: isGroup,
                            groupId: chat.id,
                            contactAvatar: chat.image,
                            contactName: chat.name,
                            isOnline: isOnline,
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
                          names: isGroup
                              ? chat.members?.map((m) => m.name).toList()
                              : null,
                          isGroup: isGroup,
                          avatar: chat.image,
                          avatars: chat.members?.map((m) => m.image).toList(),
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

    if (chat.pokes.isNotEmpty) {
      final fromPokes = chat.pokes.first.id;
      if (fromPokes.isNotEmpty) return fromPokes;
    }

    return null;
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
