import 'package:fennac_app/pages/chats/presentation/widgets/call_history_item.dart';
import 'package:flutter/material.dart';

class GroupListItem extends StatelessWidget {
  final List<String> names;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final List<String> avatars;

  const GroupListItem({
    super.key,
    required this.names,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    required this.avatars,
  });

  @override
  Widget build(BuildContext context) {
    return CallHistoryItem(
      names: names,
      lastMessage: lastMessage,
      timeAgo: time,
      unreadCount: unreadCount,
      avatars: avatars,
      isGroup: true,
    );
  }
}
