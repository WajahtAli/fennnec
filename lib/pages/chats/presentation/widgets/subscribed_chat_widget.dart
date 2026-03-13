import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/call_history_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/reusable_widgets/horizontal_avatar_list.dart';
import 'package:fennac_app/widgets/custom_search_field.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class SubscribedChatWidget extends StatefulWidget {
  const SubscribedChatWidget({super.key});

  @override
  State<SubscribedChatWidget> createState() => _SubscribedChatWidgetState();
}

class _SubscribedChatWidgetState extends State<SubscribedChatWidget> {
  int? _tappedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox(height: 12),
          CustomSearchField(hintText: 'Search'),
          CustomSizedBox(height: 16),
          const HorizontalAvatarList(),
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
          BlocBuilder<ChatLandingCubit, ChatLandingState>(
            builder: (context, state) {
              if (state is ChatLandingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatLandingLoaded) {
                final chats = state.response.data.chats;
                if (chats.isEmpty) {
                  return const Center(child: Text('No chats found'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final isHighlighted = _tappedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        if (chat.type == 'poke') {
                          context.router.push(
                            GetPockedRoute(
                              group: Group(
                                id: chat.id,
                                name: chat.name,
                                members: [
                                  Member(
                                    id: chat.meta['fromUserId'] ?? '',
                                    name: chat.name,
                                    coverImage: chat.image,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Navigation for other types
                          context.router.push(
                            GroupChatRoute(
                              isGroup: chat.type == 'group',
                              groupId: chat.id,
                              contactAvatar: chat.image,
                              contactName: chat.name,
                              isOnline: true, // Placeholder
                            ),
                          );
                        }
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
                          chatModel: chat,
                          timeAgo: '', // Need time from chat model if available
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          showBorder: index != chats.length - 1,
                          backgroundColor: isHighlighted
                              ? ColorPalette.primary.withValues(alpha: 0.15)
                              : null,
                        ),
                      ),
                    );
                  },
                );
              } else if (state is ChatLandingError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox();
            },
          ),
          CustomSizedBox(height: MediaQuery.paddingOf(context).bottom + 30),
        ],
      ),
    );
  }
}
