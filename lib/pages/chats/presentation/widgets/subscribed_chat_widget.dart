import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/call_history_item.dart';
import 'package:fennac_app/reusable_widgets/horizontal_avatar_list.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: DummyConstants.chats.length,
            itemBuilder: (context, index) {
              final chat = DummyConstants.chats[index];
              final isHighlighted = _tappedIndex == index;

              return GestureDetector(
                onTap: () {
                  if (chat.isPoked) {
                    context.router.push(
                      GetPockedRoute(group: DummyConstants.groups[1]),
                    );
                  } else {
                    // VxToast.show(message: 'Coming Soon!');
                    context.router.push(
                      GroupChatRoute(
                        isGroup: chat.isGroup,
                        groupId: chat.id,
                        contactAvatar: chat.avatar,
                        contactName: chat.name,
                        isOnline: chat.isOnline,
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
                  // Add navigation or action here
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
                    name: chat.isGroup ? null : chat.name,
                    names: chat.isGroup ? chat.names : null,
                    isGroup: chat.isGroup,
                    avatar: chat.avatar,
                    avatars: chat.avatars,
                    timeAgo: chat.timeAgo,
                    isPoked: chat.isPoked,
                    lastMessage: chat.message,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    showBorder: index != DummyConstants.chats.length - 1,
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
  }
}
