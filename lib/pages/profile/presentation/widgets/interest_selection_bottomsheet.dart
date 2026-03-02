import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/continue_button.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/interest_selection_widget.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/state/create_account_state.dart';
import '../../../kyc/presentation/screen/kyc_screen.dart';

class InterestSelectionBottomSheet extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    final loginCubit = Di().sl<LoginCubit>();

    kycCubit.selectedInterests = [];

    // Collect all selected vibes into a flat list
    final vibes = loginCubit.userData?.user?.vibes;
    List<String> userVibes = [];
    if (vibes != null) {
      userVibes.addAll(vibes.sportsAndOutdoor ?? []);
      userVibes.addAll(vibes.foodAndDrink ?? []);
      userVibes.addAll(vibes.musicAndArts ?? []);
      userVibes.addAll(vibes.travelAndAdventure ?? []);
      userVibes.addAll(vibes.techAndGaming ?? []);
      if (vibes.readingAndLearning is List) {
        userVibes.addAll(List<String>.from(vibes.readingAndLearning));
      }
      if (vibes.otherFunInterests is List) {
        userVibes.addAll(List<String>.from(vibes.otherFunInterests));
      }
    }

    // Map backend saved values back to the UI values with emojis
    kycCubit.selectedInterests = DummyConstants.interestCategories.values
        .expand((element) => element)
        .where((interest) {
          final stripped = interest
              .replaceAll(RegExp(r'[\p{Emoji}]+', unicode: true), '')
              .trim()
              .toLowerCase();
          return userVibes.contains(stripped.toLowerCase());
        })
        .toList();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const InterestSelectionBottomSheet(),
    );
  }

  const InterestSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
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
            text: 'Your Interests',
            style: AppTextStyles.h2(context).copyWith(
              fontWeight: FontWeight.bold,
              color: isLightTheme(context) ? Colors.black : Colors.white,
            ),
          ),
          const CustomSizedBox(height: 24),
          const Expanded(
            child: SingleChildScrollView(child: InterestSelectionWidget()),
          ),
          const CustomSizedBox(height: 24),
          SafeArea(
            child: BlocBuilder(
              bloc: createAccount,
              builder: (context, state) {
                return ContinueButton(
                  text: 'Done',
                  isLoading: createAccount.state is CreateAccountLoading,
                  onTap: () async {
                    if (kycCubit.selectedInterests.isEmpty) {
                      return;
                    }
                    if (kycCubit.selectedInterests.length < 7) {
                      VxToast.show(
                        message: 'Please select at least 7 interests',
                      );
                      return;
                    }
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

  static final kycCubit = Di().sl<KycCubit>();
}
