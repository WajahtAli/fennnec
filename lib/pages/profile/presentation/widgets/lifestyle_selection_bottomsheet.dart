import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/screen/kyc_screen.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/continue_button.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/lifestyle_selection_widget.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/state/create_account_state.dart';

class LifestyleSelectionBottomSheet extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    final kycCubit = Di().sl<KycCubit>();
    final loginCubit = Di().sl<LoginCubit>();

    kycCubit.selectedLifestyles = [];

    final savedLifestyles = loginCubit.userData?.user?.lifestyleLikes ?? [];
    // Map backend saved values back to the UI values with emojis
    kycCubit.selectedLifestyles = DummyConstants.lifestyles.where((lifestyle) {
      final stripped = lifestyle
          .replaceAll(RegExp(r'[\p{Emoji}]+', unicode: true), '')
          .trim()
          .toLowerCase();
      return savedLifestyles.contains(stripped.toLowerCase());
    }).toList();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LifestyleSelectionBottomSheet(),
    );
  }

  const LifestyleSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 40),
      decoration: BoxDecoration(
        color: isLightTheme(context) ? Colors.white : ColorPalette.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            text: 'Your Lifestyle',
            style: AppTextStyles.h2(context).copyWith(
              fontWeight: FontWeight.bold,
              color: isLightTheme(context) ? Colors.black : Colors.white,
            ),
          ),
          const CustomSizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              text: "What's your lifestyle like?",
              style: AppTextStyles.inputLabel(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const CustomSizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: LifestyleSelectionWidget(),
          ),
          const CustomSizedBox(height: 48),
          SafeArea(
            child: BlocBuilder(
              bloc: createAccount,
              builder: (context, state) {
                return ContinueButton(
                  text: 'Done',
                  isLoading: createAccount.state is CreateAccountLoading,
                  onTap: () async {
                    await createAccount.updateProfile();
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
