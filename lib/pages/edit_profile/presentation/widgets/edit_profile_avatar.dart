import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class EditProfileAvatar extends StatelessWidget {
  final VoidCallback onEditTap;
  final String? imageUrl;
  final double size;

  const EditProfileAvatar({
    super.key,
    required this.onEditTap,
    this.imageUrl,
    this.size = 128,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileAvatar(
      isShowEditButton: true,
      onEditTap: onEditTap,
      imageUrl: imageUrl?.isNotEmpty == true
          ? imageUrl!
          : DummyConstants.avatarPaths[0],
      size: size,
    );
  }
}
