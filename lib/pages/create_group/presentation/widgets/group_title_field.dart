import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class GroupTitleField extends StatelessWidget {
  final CreateGroupCubit cubit;
  final TextEditingController controller;
  final bool readOnly;

  const GroupTitleField({
    super.key,
    required this.cubit,
    required this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Group Title',
          style: AppTextStyles.subHeading(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        CustomLabelTextField(
          controller: controller,
          readOnly: readOnly,
          hintText: 'Enter group title',
          hintStyle: AppTextStyles.body(context).copyWith(
            color: isLight
                ? ColorPalette.black
                : ColorPalette.white.withValues(alpha: 0.4),
          ),
          filled: false,
          onChanged: (value) {
            if (readOnly) return;
            cubit.updateGroupTitle(value);
          },
        ),
      ],
    );
  }
}
