import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ActiveUserTile extends StatelessWidget {
  final Member? user;

  const ActiveUserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Dark card bg
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorPalette.primary, // Highlight border
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(user?.coverImage ?? ''),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(height: 8),
          AppText(
            text: 'You',
            style: AppTextStyles.bodySmall(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
