import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/state/kyc_state.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestSelectionWidget extends StatelessWidget {
  const InterestSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = Di().sl<KycCubit>();

    return BlocBuilder<KycCubit, KycState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: DummyConstants.interestCategories.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Title
                AppText(
                  text: entry.key,
                  style: AppTextStyles.bodyLarge(context).copyWith(
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const CustomSizedBox(height: 8),
                // Interest Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: entry.value.map((interest) {
                    final isSelected = cubit.selectedInterests.contains(
                      interest,
                    );
                    // Count selected interests in this category
                    final selectedInCategory = entry.value
                        .where((item) => cubit.selectedInterests.contains(item))
                        .length;
                    final isMaxReached = selectedInCategory >= 3 && !isSelected;
                    return AppInkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: isMaxReached
                          ? null
                          : () => cubit.toggleInterest(interest),
                      child: Opacity(
                        opacity: isMaxReached ? 0.4 : 1.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorPalette.primary
                                : isLightTheme(context)
                                ? ColorPalette.textGrey
                                : ColorPalette.secondary.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? ColorPalette.primary
                                  : ColorPalette.primary,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: AppText(
                            text: interest,
                            style: AppTextStyles.inputLabel(context).copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
