import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:fennac_app/reusable_widgets/horizontal_avatar_list.dart';
import 'package:flutter/material.dart';

class GroupDetailMembersAvatar extends StatelessWidget {
  final List<MemberModel> members;
  final Function(MemberModel)? onTap;

  const GroupDetailMembersAvatar({
    super.key,
    required this.members,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) return const SizedBox.shrink();

    return HorizontalAvatarList(
      members: members,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemSpacing: 12,
      onAvatarTap: onTap,
      nameSpacing: 6,
    );
  }
}
