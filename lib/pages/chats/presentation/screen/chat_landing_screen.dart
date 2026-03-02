import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/call_history_item.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/chat_tab_selector.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/group_list_item.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/premium_card.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/subscribed_chat_widget.dart';
import 'package:fennac_app/widgets/custom_search_field.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatLandingScreen extends StatefulWidget {
  const ChatLandingScreen({super.key});

  @override
  State<ChatLandingScreen> createState() => _ChatLandingScreenState();
}

class _ChatLandingScreenState extends State<ChatLandingScreen> {
  final ChatLandingCubit _chatLandingCubit = Di().sl<ChatLandingCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.secondary,
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: BlocBuilder<ChatLandingCubit, ChatLandingState>(
          bloc: _chatLandingCubit,
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  const CustomSizedBox(height: 16),
                  ChatTabSelector(),
                  const CustomSizedBox(height: 8),
                  Expanded(
                    child: _chatLandingCubit.selectedTabIndex == 0
                        ? _buildChatsContent()
                        : _buildCallsContent(),
                  ),
                  CustomSizedBox(
                    height: MediaQuery.paddingOf(context).bottom + 30,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatsContent() {
    // Check if user is subscribed
    final isSubscribed =
        _chatLandingCubit.subscriptionStatus == SubscriptionStatus.subscribed;

    if (isSubscribed) {
      return const SubscribedChatWidget();
    }

    // Default content when not subscribed
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSizedBox(height: 16),
          const PremiumCard(),
          const CustomSizedBox(height: 16),
          // Your Groups section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Your Groups',
              style: AppTextStyles.subHeading(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const CustomSizedBox(height: 8),
          // Group list
          ...DummyConstants.groupsChat.map((group) {
            return InkWell(
              onTap: () {
                Di().sl<ChatLandingCubit>().updateSubscriptionStatus(
                  SubscriptionStatus.subscribed,
                );
              },
              child: GroupListItem(
                names: List<String>.from(group['names']),
                lastMessage: group['lastMessage'],
                time: group['time'],
                avatars: List<String>.from(group['avatars']),
              ),
            );
          }),
          CustomSizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }

  Widget _buildCallsContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSizedBox(height: 12),
          CustomSearchField(hintText: 'Search'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Call History',
              style: AppTextStyles.subHeading(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),

          ...DummyConstants.callHistory.map((call) {
            if (call['isGroup']) {
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (!mounted) return;
                  VxToast.show(message: 'Call feature coming soon!');
                },
                child: CallHistoryItem(
                  names: List<String>.from(call['names']),
                  callType: call['callType'],
                  duration: call['duration'],
                  timeAgo: call['timeAgo'],
                  avatars: List<String>.from(call['avatars']),
                  isGroup: true,
                ),
              );
            } else {
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (!mounted) return;
                  VxToast.show(message: 'Call feature coming soon!');
                },
                child: CallHistoryItem(
                  name: call['name'],
                  callType: call['callType'],
                  duration: call['duration'],
                  timeAgo: call['timeAgo'],
                  avatar: call['avatar'],
                  isGroup: false,
                ),
              );
            }
          }),
          CustomSizedBox(height: MediaQuery.paddingOf(context).bottom + 30),
        ],
      ),
    );
  }
}
