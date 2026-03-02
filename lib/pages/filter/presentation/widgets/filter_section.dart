import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'filter_pill.dart';
import 'filter_selection_bottom_sheet.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onOptionChanged;
  final Widget Function(BuildContext context)? bottomSheetBuilder;
  final ValueNotifier<bool>? blurNotifier;
  final VoidCallback? onTap;

  const FilterSection({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionChanged,
    this.bottomSheetBuilder,
    this.blurNotifier,
    this.onTap,
  });

  Future<void> _showFilterBottomSheet(BuildContext context) async {
    blurNotifier?.value = true;

    try {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) =>
            bottomSheetBuilder?.call(context) ??
            FilterSelectionBottomSheet(
              title: title,
              options: options,
              selectedOption: selectedOption,
              onOptionSelected: onOptionChanged,
            ),
      );
    } finally {
      blurNotifier?.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () =>
              onTap != null ? onTap!() : _showFilterBottomSheet(context),
          child: Container(
            height: 110,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isLightTheme(context)
                  ? ColorPalette.textGrey
                  : ColorPalette.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: AppTextStyles.h5(context).copyWith(
                        color: isLightTheme(context)
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SvgPicture.asset(
                      Assets.icons.arrowRight.path,
                      colorFilter: ColorFilter.mode(
                        isLightTheme(context)
                            ? Colors.black.withValues(alpha: 0.5)
                            : Colors.white70,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                CustomSizedBox(height: 16),
                FilterPill(
                  label: selectedOption,
                  isSelected: true,
                  onTap: () => onTap != null
                      ? onTap!()
                      : _showFilterBottomSheet(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
