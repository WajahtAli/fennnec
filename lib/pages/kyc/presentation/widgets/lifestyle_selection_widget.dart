import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/state/kyc_state.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LifestyleSelectionWidget extends StatelessWidget {
  const LifestyleSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      bloc: Di().sl<KycCubit>(),
      builder: (context, state) {
        final cubit = Di().sl<KycCubit>();

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: DummyConstants.lifestyles.map((lifestyle) {
            final isSelected = cubit.selectedLifestyles.contains(lifestyle);

            return AppInkWell(
              borderRadius: BorderRadius.circular(48),
              onTap: () => cubit.toggleLifestyle(lifestyle),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorPalette.primary
                      : isLightTheme(context)
                      ? ColorPalette.textGrey
                      : ColorPalette.secondary,
                  borderRadius: BorderRadius.circular(48),

                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : ColorPalette.primary,
                    width: 1,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: ColorPalette.primary.withValues(alpha: 0.1),
                  //     blurRadius: 3,
                  //     spreadRadius: 0,
                  //     offset: const Offset(0, 8),
                  //   ),
                  //   BoxShadow(
                  //     color: ColorPalette.primary.withValues(alpha: 0.1),
                  //     blurRadius: 3,
                  //     spreadRadius: 0,
                  //     offset: const Offset(0, 4),
                  //   ),
                  //   BoxShadow(
                  //     color: ColorPalette.primary.withValues(alpha: 0.1),
                  //     blurRadius: 3,
                  //     spreadRadius: 0,
                  //     offset: const Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: AppText(
                  text: lifestyle,
                  style: AppTextStyles.chipLabel(context).copyWith(
                    color: isSelected
                        ? Colors.white
                        : isLightTheme(context)
                        ? Colors.black.withValues(alpha: 0.7)
                        : Colors.white.withValues(alpha: 0.7),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
