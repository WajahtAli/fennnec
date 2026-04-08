import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/chat_app_bar.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/message_input_field.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/message_list.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GroupChatScreen extends StatefulWidget {
  final bool isGroup;
  final String groupId;
  final String? contactName;
  final String? contactAvatar;
  final bool isOnline;

  const GroupChatScreen({
    super.key,
    this.isGroup = true,
    required this.groupId,
    this.contactName,
    this.contactAvatar,
    this.isOnline = false,
  });

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.secondary,
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          top: false,
          bottom: true,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: MessageList(
                      isGroup: widget.isGroup,
                      groupId: widget.groupId,
                    ),
                  ),
                  MessageInputField(isGroup: widget.isGroup),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ChatAppBar(
                  isGroup: widget.isGroup,
                  contactName: widget.contactName,
                  contactAvatar: widget.contactAvatar,
                  isOnline: widget.isOnline,
                  chatId: widget.groupId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
