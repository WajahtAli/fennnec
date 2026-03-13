import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/call_history_item.dart';
import 'package:flutter/material.dart';

class GroupListItem extends StatelessWidget {
  final List<String> names;
  final String lastMessage;
  final String time;
  final List<String> avatars;
  final ChatModel? chat;

  const GroupListItem({
    super.key,
    required this.names,
    required this.lastMessage,
    required this.time,
    required this.avatars,
    this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return CallHistoryItem(
      chatModel: chat,
      names: names,
      lastMessage: lastMessage,
      timeAgo: time,
      avatars: avatars,
      isGroup: true,
    );
  }
}
