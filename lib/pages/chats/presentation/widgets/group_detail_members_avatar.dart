import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/reusable_widgets/horizontal_avatar_list.dart';
import 'package:flutter/material.dart';

class GroupDetailMembersAvatar extends StatelessWidget {
  const GroupDetailMembersAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarSections = [
      _AvatarSection(
        avatars: DummyConstants.groupImages,
        names: const [
          'Brenda',
          'Jack',
          'Nancy',
          'Jeff',
          'Anna',
          'John',
          'Alice',
          'You',
          'Emma',
          'James',
        ],
      ),
      _AvatarSection(
        avatars: DummyConstants.avatarPaths,
        names: const [
          'Liam',
          'Olivia',
          'Mason',
          'Sophia',
          'Noah',
          'Mia',
          'Ethan',
          'Aria',
        ],
      ),
    ];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: avatarSections.length,
      separatorBuilder: (context, _) {
        return Container(
          width: 408,
          height: 2,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: const [
                Color.fromRGBO(95, 0, 219, 0.0),
                Colors.white,
                Color.fromRGBO(95, 0, 219, 0.0),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
      itemBuilder: (context, index) {
        final section = avatarSections[index];
        return HorizontalAvatarList(
          avatars: section.avatars,
          names: section.names,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          avatarRadius: 34,
          itemSpacing: 12,
          nameSpacing: 6,
        );
      },
    );
  }
}

class _AvatarSection {
  final List<String> avatars;
  final List<String> names;

  const _AvatarSection({required this.avatars, required this.names});
}
