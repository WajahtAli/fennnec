import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatLandingCubit, ChatLandingState>(
      bloc: Di().sl<ChatLandingCubit>(),
      builder: (context, state) {
        if (state.isLoadingData && state.chats.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null && state.chats.isEmpty) {
          return Center(child: Text(state.errorMessage!));
        }

        final chats = state.chats;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSizedBox(height: 12),
              const CustomSearchField(hintText: 'Search'),
              const CustomSizedBox(height: 16),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  final isHighlighted = _tappedIndex == index;
                  final isGroup = chat.type == 'group';

                  return GestureDetector(
                    onTap: () {
                      if (chat.type == 'poke') {
                        context.router.push(
                          GetPockedRoute(pokeId: chat.meta['pokeId']),
                        );
                      } else {
                        context.router.push(
                          GroupChatRoute(
                            isGroup: isGroup,
                            groupId: chat.id,
                            contactAvatar: chat.image,
                            contactName: chat.name,
                            isOnline: false,
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
                        name: isGroup ? null : chat.name,
                        names: isGroup
                            ? chat.members?.map((m) => m.name).toList()
                            : null,
                        isGroup: isGroup,
                        avatar: chat.image,
                        avatars: chat.members?.map((m) => m.image).toList(),
                        timeAgo: chat.lastMessageAt != null
                            ? _getTimeAgo(chat.lastMessageAt!)
                            : '',
                        isPoked: chat.type == 'poke',
                        lastMessage: chat.lastMessage,
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
              ),
              CustomSizedBox(height: MediaQuery.paddingOf(context).bottom + 30),
            ],
          ),
        );
      },
    );
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
