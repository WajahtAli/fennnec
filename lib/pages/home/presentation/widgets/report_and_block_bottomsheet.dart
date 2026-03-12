import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/groups_cubit.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import 'package:fennac_app/pages/home/presentation/bloc/state/groups_state.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ReportAndBlockBottomSheet extends StatefulWidget {
  final String groupId;
  final String? userId;
  final ReportTargetType reportTargetType;

  const ReportAndBlockBottomSheet({
    super.key,
    required this.groupId,
    this.userId,
    this.reportTargetType = ReportTargetType.group,
  });

  @override
  State<ReportAndBlockBottomSheet> createState() =>
      _ReportAndBlockBottomSheetState();
}

class _ReportAndBlockBottomSheetState extends State<ReportAndBlockBottomSheet> {
  final GroupsCubit _groupsCubit = Di().sl<GroupsCubit>();
  String? _selectedReason;
  final TextEditingController _reasonController = TextEditingController();
  final ValueNotifier<bool> _blurNotifier = ValueNotifier<bool>(false);

  final List<String> _reportReasons = [
    'Inappropriate messages or content',
    'Fake or misleading profile(s)',
    'Harassment or bullying',
    'Spam or scam behavior',
    'Safety or privacy concern',
    'Other',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    _blurNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    return ValueListenableBuilder<bool>(
      valueListenable: _blurNotifier,
      builder: (context, isBlurred, child) {
        return Stack(
          children: [
            AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: viewInsets.bottom),
              child: Container(
                height: getHeight(context) * 0.87,
                decoration: BoxDecoration(
                  gradient: isDarkTheme(context)
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [const Color(0xFF16003F), ColorPalette.black],
                        )
                      : null,
                  color: isLightTheme(context) ? Colors.white : null,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBackgroundContainer(
                          icon: Assets.icons.slash.path,
                        ),
                        const CustomSizedBox(height: 24),

                        AppText(
                          text: 'Report & Block',
                          style: AppTextStyles.h2(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        const CustomSizedBox(height: 16),
                        AppText(
                          textAlign: TextAlign.center,
                          text:
                              'Select a reason for reporting this user. They won\'t know you\'ve reported or blocked them.',
                          style: AppTextStyles.body(context).copyWith(
                            color: isLightTheme(context)
                                ? ColorPalette.black
                                : Colors.white70,
                          ),
                        ),
                        const CustomSizedBox(height: 16),
                        Container(
                          // height: 340,
                          decoration: BoxDecoration(
                            color: isLightTheme(context)
                                ? ColorPalette.textGrey
                                : ColorPalette.black.withValues(alpha: 0.3),
                            border: Border.all(
                              color: ColorPalette.grey.withValues(alpha: 0.5),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: List.generate(_reportReasons.length, (
                              index,
                            ) {
                              final reason = _reportReasons[index];
                              final isSelected = _selectedReason == reason;

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedReason = reason;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                // Outer ring
                                                Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          isLightTheme(context)
                                                          ? (isSelected
                                                                ? ColorPalette
                                                                      .primary
                                                                : ColorPalette
                                                                      .black)
                                                          : Colors.white,
                                                      width: 2,
                                                    ),
                                                  ),
                                                ),
                                                // Middle dark ring - only show in dark theme
                                                if (isDarkTheme(context))
                                                  Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ColorPalette
                                                          .cardBlack,
                                                    ),
                                                  ),
                                                // Inner fill toggles selected state
                                                if (isSelected)
                                                  Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          isLightTheme(context)
                                                          ? ColorPalette.primary
                                                          : Colors.white,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: AppText(
                                              text: reason,
                                              style: AppTextStyles.body(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (index < _reportReasons.length - 1)
                                    Divider(
                                      height: 2,
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                ],
                              );
                            }),
                          ),
                        ),
                        const CustomSizedBox(height: 28),

                        CustomLabelTextField(
                          label: 'Enter a Reason',
                          controller: _reasonController,
                          fillColor: Colors.transparent,
                          filled: false,
                          hintText: 'Type your reason here...',
                        ),
                        const CustomSizedBox(height: 28),
                        BlocBuilder(
                          bloc: _groupsCubit,
                          builder: (context, state) {
                            return CustomElevatedButton(
                              icon: state is GroupsLoading
                                  ? SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Lottie.asset(
                                        Assets.animations.loadingSpinner,
                                        width: 24,
                                        height: 24,
                                      ),
                                    )
                                  : null,
                              text: state is GroupsLoading
                                  ? ''
                                  : 'Submit Report',
                              onTap: () async {
                                if (_selectedReason == null) {
                                  VxToast.show(
                                    message: 'Please select a reason.',
                                  );

                                  return;
                                }
                                if (_selectedReason == 'Other' &&
                                    _reasonController.text.trim().isEmpty) {
                                  VxToast.show(
                                    message:
                                        'Please enter a reason for reporting.',
                                  );
                                  return;
                                }

                                try {
                                  final customReason =
                                      _selectedReason == 'Other'
                                      ? _reasonController.text
                                      : null;

                                  if (widget.reportTargetType ==
                                      ReportTargetType.user) {
                                    final userId = widget.userId;
                                    if (userId == null || userId.isEmpty) {
                                      throw Exception(
                                        'Unable to report this user right now.',
                                      );
                                    }

                                    await _groupsCubit.reportUser(
                                      userId: userId,
                                      reason: _selectedReason!,
                                      customReason: customReason,
                                    );

                                    Di().sl<HomeCubit>().removeProfileById(
                                      userId,
                                    );
                                  } else {
                                    await _groupsCubit.reportGroup(
                                      groupId: widget.groupId,
                                      reason: _selectedReason!,
                                      customReason: customReason,
                                    );

                                    Di().sl<HomeCubit>().removeGroupById(
                                      widget.groupId,
                                    );
                                  }

                                  _blurNotifier.value = true;
                                } catch (e) {
                                  _blurNotifier.value = false;
                                  if (!mounted) return;
                                  VxToast.show(
                                    message: 'Failed to submit report: $e',
                                  );
                                  return;
                                }

                                await CustomBottomSheet.show(
                                  blurNotifier: _blurNotifier,
                                  context: context,
                                  title: 'Thanks for your report.',
                                  description:
                                      "The group/person has been blocked and removed from your matches and messages.",
                                  buttonText: 'Explore Groups',
                                  icon: AnimatedBackgroundContainer(
                                    icon: Assets.icons.checkGreen.path,
                                    isPng: true,
                                  ),
                                  onButtonPressed: () {
                                    // Pop the success bottom sheet
                                    Navigator.of(context).pop();
                                    // Pop the report and block bottom sheet
                                    Navigator.of(context).pop();
                                    // Navigate to home screen
                                    context.router.replace(
                                      const DashboardRoute(),
                                    );
                                  },
                                );

                                _blurNotifier.value = false;
                              },
                            );
                          },
                        ),
                        const CustomSizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (isBlurred)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
