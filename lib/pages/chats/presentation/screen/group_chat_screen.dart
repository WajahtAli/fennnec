import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/chat_app_bar.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/message_input_field.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/message_list.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di_container.dart';
import '../bloc/cubit/message_cubit.dart';

@RoutePage()
class GroupChatScreen extends StatefulWidget {
  final bool isGroup;
  final String groupId;
  final String? otherGroupId;
  final String? contactName;
  final String? contactAvatar;
  final bool isOnline;

  const GroupChatScreen({
    super.key,
    this.isGroup = true,
    required this.groupId,
    this.otherGroupId,
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
    return BlocProvider<MessageCubit>(
      create: (context) => Di().sl<MessageCubit>(),
      child: Scaffold(
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
                        otherGroupId: widget.isGroup
                            ? widget.otherGroupId
                            : widget.groupId,
                      ),
                    ),
                    MessageInputField(
                      isGroup: widget.isGroup,
                      otherGroupId: widget.isGroup
                          ? widget.otherGroupId
                          : widget.groupId,
                    ),
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
      ),
    );
  }
}
