import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/call_history_item.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/chat_tab_selector.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/group_list_item.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/premium_card.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/subscribed_chat_widget.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_search_field.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
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
  void initState() {
    super.initState();
    _chatLandingCubit.fetchChatsAndCalls();
  }

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
                    child: state.selectedTab == 0
                        ? _buildChatsContent(state)
                        : _buildCallsContent(state),
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

  Widget _buildChatsContent(ChatLandingState state) {
    // Check if user is subscribed
    final isSubscribed =
        state.subscriptionStatus == SubscriptionStatus.subscribed;

    return RefreshIndicator(
      color: ColorPalette.primary,
      backgroundColor: Colors.white,
      onRefresh: () => _chatLandingCubit.fetchChatsAndCalls(),
      child: isSubscribed
          ? const SubscribedChatWidget()
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSizedBox(height: 16),
                  if (Di()
                          .sl<LoginCubit>()
                          .userData
                          ?.user
                          ?.subscriptionActive ==
                      false)
                    const PremiumCard(),
                  const CustomSizedBox(height: 16),
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
                  if (state.chats.isNotEmpty)
                    _buildChatMemberItem(state.chats.first)
                  else
                    ...DummyConstants.groupsChat.map((group) {
                      return AppInkWell(
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
            ),
    );
  }

  Widget _buildChatMemberItem(ChatModel chat) {
    final isGroup = chat.type == 'group';
    return AppInkWell(
      onTap: () {
        Di().sl<ChatLandingCubit>().updateSubscriptionStatus(
          SubscriptionStatus.subscribed,
        );
      },
      child: GroupListItem(
        names: isGroup
            ? (chat.members?.map((m) => m.name).toList() ?? [chat.name])
            : [chat.name],
        lastMessage: chat.lastMessage,
        time: chat.lastMessageAt != null
            ? _getTimeAgo(chat.lastMessageAt!)
            : '',
        avatars: isGroup
            ? (chat.members?.map((m) => m.image).toList() ?? [chat.image])
            : [chat.image],
      ),
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

  Widget _buildCallsContent(ChatLandingState state) {
    return RefreshIndicator(
      color: ColorPalette.primary,
      backgroundColor: Colors.white,
      onRefresh: () => _chatLandingCubit.fetchChatsAndCalls(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const CustomSizedBox(height: 12),
          const CustomSearchField(hintText: 'Search'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Call History',
              style: AppTextStyles.subHeading(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (state.isLoadingData && state.calls.isEmpty)
            const Center(child: CircularProgressIndicator())
          else if (state.calls.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No call history yet',
                  style: AppTextStyles.description(context),
                ),
              ),
            )
          else
            ...state.calls.map((call) {
              final isGroup =
                  (call.members?.length ?? 0) > 1 || (call.name == null);
              return AppInkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  _onCallHistoryTap(call);
                },
                child: CallHistoryItem(
                  name: call.name,
                  names: call.members?.map((m) => m.name).toList(),
                  callType: call.callTypeLabel,
                  duration: call.duration,
                  timeAgo: call.timeAgo ?? '',
                  avatar: call.image,
                  avatars: call.members?.map((m) => m.image).toList(),
                  isGroup: isGroup,
                ),
              );
            }),
          CustomSizedBox(height: MediaQuery.paddingOf(context).bottom + 30),
        ],
      ),
    );
  }

  void _onCallHistoryTap(CallModel call) {
    if (!mounted) return;

    final isVideo =
        (call.mediaType ?? call.callTypeLabel ?? call.callType ?? '')
            .toLowerCase()
            .contains('video');

    final members = call.members ?? [];
    if (members.isEmpty) {
      VxToast.show(message: 'Unable to start call for this record.');
      return;
    }

    final mappedMembers = members
        .map(
          (m) => Member(
            id: m.id,
            firstName: m.name,
            name: m.name,
            coverImage: m.image,
          ),
        )
        .toList();

    final group = Group(
      id: call.id,
      name: call.name ?? members.map((m) => m.name).join(', '),
      members: mappedMembers,
    );

    context.router.push(
      GroupAudioCallRoute(group: group, isVideoCall: isVideo),
    );
  }
}
