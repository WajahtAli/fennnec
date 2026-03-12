import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class GroupBioField extends StatelessWidget {
  final CreateGroupCubit cubit;
  final TextEditingController controller;
  final ScrollController scrollController;
  final bool readOnly;

  const GroupBioField({
    super.key,
    required this.cubit,
    required this.controller,
    required this.scrollController,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Short Bio',
          style: AppTextStyles.subHeading(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        CustomLabelTextField(
          controller: controller,
          scrollController: scrollController,
          readOnly: readOnly,
          keyboardType: TextInputType.multiline,
          hintText: 'Type here...',
          hintStyle: AppTextStyles.body(context).copyWith(
            color: isLight
                ? ColorPalette.black
                : ColorPalette.white.withValues(alpha: 0.4),
          ),
          filled: false,
          maxLines: 4,
          onChanged: (value) {
            if (readOnly) return;
            cubit.updateGroupBio(value);
          },
        ),
      ],
    );
  }
}
