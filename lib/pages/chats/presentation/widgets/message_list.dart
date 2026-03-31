import 'dart:ui';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import 'package:fennac_app/pages/chats/data/models/message_type_enum.dart';
import 'package:fennac_app/pages/chats/data/models/reaction_model.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/message_bubble.dart';
import 'package:fennac_app/models/dummy/chat_message_model.dart';
import 'package:fennac_app/reusable_widgets/empty_widget.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MessageList extends StatefulWidget {
  final bool isGroup;
  final String groupId;

  const MessageList({super.key, required this.isGroup, required this.groupId});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _messageKeys = {};
  OverlayEntry? _reactionOverlay;
  final List<String> _availableReactions = ['👍', '😂', '🔥', '❤️', '👌', '😮'];
  final List<MessageModel> _dummyMessages = DummyConstants.getMessages()
      .asMap()
      .entries
      .map((entry) => _mapChatMessageToMessageModel(entry.value, entry.key))
      .toList();

  @override
  void initState() {
    super.initState();
    messageCubit.initializeMessages(widget.groupId, isGroup: widget.isGroup);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!messageCubit.isLoading && !messageCubit.isFetchingMore) {
        messageCubit.loadMoreMessages();
      }
    }
  }

  @override
  void dispose() {
    messageCubit.stopPolling();

    _scrollController.dispose();

    _removeReactionOverlay('', '');
    super.dispose();
  }

  static MessageModel _mapChatMessageToMessageModel(
    ChatMessage chat,
    int index,
  ) {
    return MessageModel(
      id: chat.id,
      senderId: chat.id,
      senderName: chat.name,
      senderAvatar: chat.avatar,
      content: chat.text ?? '',
      type: MessageTypeExtension.fromString(chat.type),
      imageUrls: chat.images,
      mediaDuration: chat.duration,
      mentionedUserName: chat.mentionedUser,
      sentAt: DateTime.now().subtract(Duration(minutes: index * 2)),
      isMe: chat.isMe,
      isGroup: chat.isMyGroup,
      reactions: _mapReactions(chat.reactions),
    );
  }

  static List<ReactionModel> _mapReactions(
    Map<String, List<String>> reactionsMap,
  ) {
    final List<ReactionModel> reactions = [];

    reactionsMap.forEach((emoji, userIds) {
      for (final userId in userIds) {
        reactions.add(
          ReactionModel(
            userId: userId,
            userName: userId,
            emoji: emoji,
            reactedAt: DateTime.now(),
          ),
        );
      }
    });

    return reactions;
  }

  void _showReactionOverlay(MessageModel message, bool isMineSide) {
    final key = _messageKeys[message.id];

    if (key == null || key.currentContext == null) return;

    final box = key.currentContext!.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    final size = box.size;
    final screenWidth = MediaQuery.sizeOf(context).width;
    const horizontalMargin = 12.0;
    const reactionHorizontalPadding = 14.0;
    const reactionItemWidth = 38.0;
    final preferredReactionBarWidth =
        (reactionHorizontalPadding * 2) +
        (_availableReactions.length * reactionItemWidth);
    final reactionBarWidth = preferredReactionBarWidth.clamp(
      0.0,
      screenWidth - (horizontalMargin * 2),
    );
    final reactionCenterX = position.dx + (size.width / 2);
    final reactionLeft = (reactionCenterX - (reactionBarWidth / 2)).clamp(
      horizontalMargin,
      screenWidth - horizontalMargin - reactionBarWidth,
    );
    final minReactionTop = MediaQuery.paddingOf(context).top + 8;
    final reactionTop = (position.dy - 56).clamp(
      minReactionTop,
      double.infinity,
    );

    _reactionOverlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          GestureDetector(
            onTap: () => _removeReactionOverlay(message.id, ''),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black.withOpacity(0.25)),
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy,
            width: size.width,
            child: Material(
              color: Colors.transparent,
              child: _buildMessageBubbleForOverlay(message, isMineSide),
            ),
          ),
          Positioned(
            left: reactionLeft,
            top: reactionTop,
            width: reactionBarWidth,
            child: _buildReactionBar(message),
          ),
          _buildOverlayActionBar(message, isMineSide),
        ],
      ),
    );

    Overlay.of(context).insert(_reactionOverlay!);
  }

  Widget _buildReactionBar(MessageModel message) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 180),
      tween: Tween(begin: 0.8, end: 1),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Opacity(opacity: scale, child: child),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isLightTheme(context)
                ? ColorPalette.textGrey
                : Colors.black.withOpacity(0.95),
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _availableReactions.map((emoji) {
                return GestureDetector(
                  onTap: () {
                    messageCubit.addReaction(message.id, emoji);
                    _removeReactionOverlay(message.id, emoji);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(emoji, style: const TextStyle(fontSize: 26)),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayActionBar(MessageModel message, bool isMineSide) {
    if (!isMineSide) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: MediaQuery.paddingOf(context).top + 8,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () async {
                _removeReactionOverlay(message.id, '');
                await _deleteMessageFromOverlay(message);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.trash.path),
                    SizedBox(width: 8),
                    Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteMessageFromOverlay(MessageModel message) async {
    var shouldDelete = false;
    await CustomBottomSheet.show(
      context: context,
      title: 'Delete message?',
      description: 'This action cannot be undone.',
      buttonText: 'Delete',
      secondaryButtonText: 'Cancel',
      isHorizontalButton: true,
      onButtonPressed: () {
        shouldDelete = true;
      },
      onSecondaryButtonPressed: () {
        Navigator.of(context).pop();
      },
    );

    if (!shouldDelete) return;

    if (!mounted) return;
    _removeReactionOverlay(message.id, '');
    final isDeleted = await messageCubit.deleteMessage(message.id);
    if (!mounted) return;

    if (isDeleted) {
      VxToast.show(message: 'Message deleted');
      return;
    }

    VxToast.show(message: 'Unable to delete message. Please try again.');
  }

  void _removeReactionOverlay(String messageId, String emoji) {
    _reactionOverlay?.remove();
    _reactionOverlay = null;
  }

  Widget _buildMessageBubbleForOverlay(MessageModel message, bool isMineSide) {
    return MessageBubble(
      message: message,
      isMineSide: isMineSide,
      onLongPress: () {},
      messageKey: GlobalKey(),
    );
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: isMineSide
    //       ? CrossAxisAlignment.end
    //       : CrossAxisAlignment.start,
    //   children: [
    //     if (!isMineSide)
    //       Text(
    //         message.senderName,
    //         style: AppTextStyles.body(
    //           context,
    //         ).copyWith(color: ColorPalette.white),
    //       ),
    //     Container(
    //       constraints: BoxConstraints(
    //         maxWidth: MediaQuery.of(context).size.width * 0.75,
    //       ),
    //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    //       decoration: BoxDecoration(
    //         color: isMineSide
    //             ? ColorPalette.primary
    //             : ColorPalette.secondary.withValues(alpha: 0.5),
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       child: Text(
    //         message.content,
    //         style: AppTextStyles.body(
    //           context,
    //         ).copyWith(color: ColorPalette.white, fontSize: 15),
    //       ),
    //     ),
    //     if (isMineSide)
    //       Text(
    //         DateFormat('hh:mm a').format(message.sentAt),
    //         style: AppTextStyles.body(
    //           context,
    //         ).copyWith(color: ColorPalette.white),
    //       ),
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      bloc: messageCubit,
      builder: (context, state) {
        if (messageCubit.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: ColorPalette.primary),
          );
        }

        if (messageCubit.hasError) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: EmptyWidget(
                height: 326,
                title: 'No messages yet',
                description:
                    'Your groups are matched, but no one has started the conversation. Be the first to break the ice.',
                imagePath: Assets.icons.chatGroup.path,
              ),
            ),
          );
        }

        final messages = messageCubit.messages;
        final messagesToRender = messages.isEmpty && widget.isGroup
            ? _dummyMessages
            : messages;

        if (messages.isEmpty && !widget.isGroup) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: EmptyWidget(
                height: 326,
                title: 'No messages yet',
                description:
                    'Your groups are matched, but no one has started the conversation. Be the first to break the ice.',
                imagePath: Assets.icons.chatGroup.path,
              ),
            ),
          );
        }
        return ListView.builder(
          controller: _scrollController,
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 140,
            bottom: 0,
          ),
          itemCount: messagesToRender.length,
          itemBuilder: (context, index) {
            final message = messagesToRender[index];
            final isMineSide = message.isMe;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: isMineSide
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (!isMineSide && widget.isGroup) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.senderAvatar != null) ...[
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(message.senderAvatar!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const CustomSizedBox(width: 8),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.senderName,
                                style: AppTextStyles.bodySmall(
                                  context,
                                ).copyWith(fontSize: 12),
                              ),
                              const CustomSizedBox(height: 4),
                              _buildMessageWithLongPress(message, isMineSide),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ] else
                    _buildMessageWithLongPress(message, isMineSide),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMessageWithLongPress(MessageModel message, bool isMineSide) {
    final key = _messageKeys.putIfAbsent(message.id, () => GlobalKey());

    return GestureDetector(
      onLongPress: () => _showReactionOverlay(message, isMineSide),
      child: MessageBubble(
        message: message,
        isMineSide: isMineSide,
        onLongPress: () => _showReactionOverlay(message, isMineSide),
        messageKey: key,
      ),
    );
  }
}

final MessageCubit messageCubit = Di().sl<MessageCubit>();
