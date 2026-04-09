import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/gallery_upload_widget.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/report_problem_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/report_problem_state.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  late final TextEditingController _subjectController;
  late final TextEditingController _descriptionController;
  late final ValueNotifier<bool> _isBlurNotifier;
  final ReportProblemCubit _reportProblemCubit = Di().sl<ReportProblemCubit>();
  final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController();
    _descriptionController = TextEditingController();
    _isBlurNotifier = ValueNotifier<bool>(false);
    // Clear previous media when entering the screen
    _imagePickerCubit.clearAllMedia();
  }

  @override
  void dispose() {
    _imagePickerCubit.clearAllMedia();
    _subjectController.dispose();
    _descriptionController.dispose();
    _isBlurNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportProblemCubit, ReportProblemState>(
      bloc: _reportProblemCubit,
      listener: (context, state) {
        if (state is ReportProblemSuccess) {
          CustomBottomSheet.show(
            context: context,
            icon: AnimatedBackgroundContainer(
              icon: Assets.icons.checkGreen.path,
              isPng: true,
            ),
            title: 'Report Submitted',
            description:
                'Thanks for letting us know. We will investigate and get back to you.',
            buttonText: 'Done',
            onButtonPressed: () {
              context.router.pop();
              context.router.pop();
            },
            blurNotifier: _isBlurNotifier,
          );

          _subjectController.clear();
          _descriptionController.clear();
          _imagePickerCubit.clearAllMedia();
          _reportProblemCubit.reset();
        }
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isBlurNotifier,
        builder: (context, isBlurred, _) {
          return Stack(
            children: [
              Scaffold(
                body: MovableBackground(
                  backgroundType: MovableBackgroundType.dark,
                  child: SafeArea(
                    child: Column(
                      children: [
                        CustomAppBar(title: 'Report a Problem'),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'Something not working as expected?',
                                  style: AppTextStyles.h3(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                                const CustomSizedBox(height: 12),
                                AppText(
                                  text:
                                      'Let us know what happened so we can fix it quickly.',
                                  style: AppTextStyles.body(context).copyWith(
                                    color: isLightTheme(context)
                                        ? ColorPalette.black
                                        : ColorPalette.textSecondary,
                                    height: 1.5,
                                  ),
                                ),
                                const CustomSizedBox(height: 32),

                                CustomLabelTextField(
                                  label: 'Subject',
                                  controller: _subjectController,
                                  hintText: 'Type here..',
                                  fillColor: ColorPalette.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  filled: false,
                                  labelColor: ColorPalette.white,
                                  labelStyle: AppTextStyles.bodyLarge(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w600),
                                ),
                                const CustomSizedBox(height: 24),

                                CustomLabelTextField(
                                  label: 'Description',
                                  controller: _descriptionController,
                                  hintText: 'Describe the problem..',
                                  fillColor: ColorPalette.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  filled: false,
                                  maxLines: 6,
                                  minLines: 4,
                                  labelColor: ColorPalette.white,
                                  labelStyle: AppTextStyles.bodyLarge(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w600),
                                ),
                                const CustomSizedBox(height: 28),

                                AppText(
                                  text: 'Attachment (Optional)',
                                  style: AppTextStyles.bodyLarge(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w600),
                                ),
                                const CustomSizedBox(height: 12),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 86,
                                      height: 188,
                                      child: const GalleryUploadWidget(
                                        containerIndex: 0,
                                      ),
                                    ),
                                    const CustomSizedBox(width: 8),
                                    SizedBox(
                                      width: 86,
                                      height: 188,
                                      child: const GalleryUploadWidget(
                                        containerIndex: 1,
                                      ),
                                    ),
                                  ],
                                ),

                                const CustomSizedBox(height: 36),
                                BlocBuilder<
                                  ReportProblemCubit,
                                  ReportProblemState
                                >(
                                  bloc: _reportProblemCubit,
                                  builder: (context, state) {
                                    return CustomElevatedButton(
                                      icon: _reportProblemCubit.isSubmitting
                                          ? SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Lottie.asset(
                                                Assets
                                                    .animations
                                                    .loadingSpinner,
                                              ),
                                            )
                                          : null,
                                      text: _reportProblemCubit.isSubmitting
                                          ? ''
                                          : 'Submit Report',
                                      onTap: _reportProblemCubit.isSubmitting
                                          ? () {}
                                          : _submitReport,
                                    );
                                  },
                                ),
                                const CustomSizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isBlurred)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.2),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _submitReport() async {
    if (_imagePickerCubit.mediaList.isNotEmpty) {
      await Di().sl<CreateAccountCubit>().uploadMedia(
        filePath: _imagePickerCubit.mediaList.first.path,
      );
    }

    await _reportProblemCubit.submitReport(
      subject: _subjectController.text,
      description: _descriptionController.text,
      attachments: Di().sl<CreateAccountCubit>().mediaLinks,
    );
  }
}
