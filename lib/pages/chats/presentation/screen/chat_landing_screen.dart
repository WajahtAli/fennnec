import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/core/sockets/sockets_service.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/call_history_item.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/chat_tab_selector.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/group_list_item.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/premium_card.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/subscribed_chat_widget.dart';
import 'package:fennac_app/pages/call/presentation/bloc/cubit/call_cubit.dart';
import 'package:fennac_app/reusable_widgets/empty_widget.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_search_field.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

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
    SocketService.onChatRelatedUpdate(() {
      if (!mounted) return;
      _chatLandingCubit.fetchChatsAndCalls();
    });
  }

  @override
  void dispose() {
    SocketService.offChatRelatedUpdate();
    super.dispose();
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

  Widget _buildChatsContent(ChatLandingState state) {
    // Check if user is subscribed
    final isSubscribed =
        state.subscriptionStatus == SubscriptionStatus.subscribed;

    return RefreshIndicator(
      color: ColorPalette.primary,
      backgroundColor: Colors.white,
      onRefresh: () => _chatLandingCubit.fetchChatsAndCalls(),
      child: isSubscribed
          ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: const SubscribedChatWidget(),
            )
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
                          unreadCount: (group['unreadCount'] as int?) ?? 0,
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
        unreadCount: chat.unreadCount,
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

  Widget _buildCallsContent() {
    return BlocBuilder<ChatLandingCubit, ChatLandingState>(
      bloc: _chatLandingCubit,
      builder: (context, state) {
        final callsToShow = _chatLandingCubit.isCallsSearching
            ? _chatLandingCubit.filteredCalls
            : state.calls;

        return RefreshIndicator(
          color: ColorPalette.primary,
          backgroundColor: Colors.white,
          onRefresh: () => _chatLandingCubit.fetchChatsAndCalls(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const CustomSizedBox(height: 12),
              CustomSearchField(
                hintText: 'Search',
                onChanged: _chatLandingCubit.onCallsSearchChanged,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Text(
                  'Call History',
                  style: AppTextStyles.subHeading(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              if (state.isLoadingData && state.calls.isEmpty)
                Center(child: Lottie.asset(Assets.animations.loadingSpinner))
              else if (callsToShow.isEmpty)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: EmptyWidget(
                      title: _chatLandingCubit.isCallsSearching
                          ? 'No results found'
                          : 'No calls yet!',
                      description: _chatLandingCubit.isCallsSearching
                          ? 'Try searching with a different name or call type.'
                          : 'Voice and video calls will appear here once you start talking.',
                      imagePath: Assets.icons.noLikes.path,
                      showButton: true,
                      buttonText: 'Refresh',
                      onButtonTap: () {},
                    ),
                  ),
                )
              else
                ...callsToShow.map((call) {
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
      },
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

    final currentUserId = Di().sl<LoginCubit>().userData?.user?.id;
    final participantIds = members
        .map((m) => m.id)
        .where((id) => id.isNotEmpty && id != currentUserId)
        .toList();

    if (participantIds.isEmpty) {
      VxToast.show(message: 'Unable to start call for this record.');
      return;
    }

    final callCubit = Di().sl<CallCubit>();
    final callType = participantIds.length > 1 ? 'group' : 'individual';

    callCubit
        .startCall(
          mediaType: isVideo ? 'video' : 'audio',
          callType: callType,
          participantIds: participantIds,
        )
        .then((response) {
          if (!mounted || response == null) {
            VxToast.show(message: 'Unable to start call. Please try again.');
            return;
          }

          // if (isVideo) {
          //   AutoRouter.of(context).push(VideoCallRoute());
          // } else {
          AutoRouter.of(context).push(AudioCallRoute());
          // }
        });
  }
}
