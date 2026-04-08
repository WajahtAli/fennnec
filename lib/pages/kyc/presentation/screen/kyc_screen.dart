import 'dart:developer';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/continue_button.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/date_picker_widget.dart';
import 'package:fennac_app/reusable_widgets/dropdown_field_widget.dart';
import 'package:fennac_app/reusable_widgets/gender_selection_widget.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app/constants/media_query_constants.dart';
import '../../../auth/presentation/bloc/state/create_account_state.dart';
import '../bloc/state/kyc_state.dart';

@RoutePage()
class KycScreen extends StatefulWidget {
  final bool? isEditMode;
  const KycScreen({super.key, this.isEditMode = false});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final KycCubit _kycCubit = Di().sl<KycCubit>();
  final CreateAccountCubit _createAccountCubit = Di().sl<CreateAccountCubit>();
  final LoginCubit _loginCubit = Di().sl<LoginCubit>();
  final ValueNotifier<bool> _isBlurNotifier = ValueNotifier(false);
  late ValueNotifier<bool> _isInitialized;

  LoginUser? get _resolvedUser {
    if (widget.isEditMode == true) {
      return _loginCubit.userData?.user;
    }
    return _createAccountCubit.createdUser;
  }

  @override
  void initState() {
    super.initState();
    _isInitialized = ValueNotifier(widget.isEditMode != true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        _initializeFromUser();
        _isInitialized.value = true;
      });
    });
  }

  void _initializeFromUser() {
    final user = _resolvedUser;

    if (user != null) {
      log('KYC init for user: ${user.gender}');
      _kycCubit.setSelectedDate(user.dob);
      _kycCubit.selectGender(user.gender ?? '');
      _kycCubit.selectSexualOrientations(user.sexualOrientation ?? []);
      _kycCubit.selectPronouns(user.pronouns ?? '');
      _kycCubit.jobTitleController.text = user.jobTitle ?? '';
      _kycCubit.educationController.text = user.education ?? '';
      _kycCubit.shortBioController.text = user.shortBio ?? '';
    }
  }

  @override
  void dispose() {
    _isBlurNotifier.dispose();
    _isInitialized.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.medium,
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: BlocBuilder(
                  bloc: _kycCubit,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.isEditMode ?? false) CustomBackButton(),
                          CustomSizedBox(height: 8),
                          // Greeting
                          if (widget.isEditMode == true)
                            BlocBuilder(
                              bloc: _createAccountCubit,
                              builder: (context, state) {
                                final user = _resolvedUser;

                                return AppText(
                                  text: 'Hi, ${user?.firstName ?? ''}!',
                                  style: AppTextStyles.h1(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w500),
                                );
                              },
                            )
                          else
                            BlocBuilder(
                              bloc: _createAccountCubit,
                              builder: (context, state) {
                                final user = _resolvedUser;

                                return AppText(
                                  text: 'Hi, ${user?.firstName ?? ''}!',
                                  style: AppTextStyles.h2(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w500),
                                );
                              },
                            ),

                          CustomSizedBox(height: 16),
                          AppText(
                            text: "Let's start with the basics",
                            style: AppTextStyles.h4(
                              context,
                            ).copyWith(fontWeight: FontWeight.w500),
                          ),
                          CustomSizedBox(height: 24),
                          // Date of Birth
                          AppText(
                            text: 'Select Your Date of Birth',
                            style: AppTextStyles.inputLabel(
                              context,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          CustomSizedBox(height: 10),
                          BlocBuilder<KycCubit, KycState>(
                            bloc: _kycCubit,
                            builder: (context, state) {
                              return ValueListenableBuilder<bool>(
                                valueListenable: _isInitialized,
                                builder: (context, isInitialized, _) {
                                  if (!isInitialized) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return DatePickerWidget(
                                    initialDate: _kycCubit.selectedDate,
                                    onDateSelected: (date) {
                                      _kycCubit.selectedDate = date;
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          CustomSizedBox(height: 24),

                          // Gender Selection
                          AppText(
                            text: 'Select Gender',
                            style: AppTextStyles.inputLabel(
                              context,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          CustomSizedBox(height: 10),
                          GenderSelectionWidget(
                            selectedGender: _kycCubit.selectedGender,
                            onGenderSelected: (gender) {
                              _kycCubit.selectGender(gender);
                            },
                          ),
                          CustomSizedBox(height: 24),

                          // Sexual Orientation
                          DropdownFieldWidget(
                            label: 'Select Sexual Orientation',
                            subtitle: 'Choose all that describe you best.',
                            selectedValues:
                                _kycCubit.selectedSexualOrientations,
                            options: DummyConstants.sexualOrientations,
                            selectionType: SelectionType.multiple,
                            onMultipleSelected: (values) {
                              _kycCubit.selectSexualOrientations(values);
                              log(
                                'Selected selectedSexualOrientations: ${_kycCubit.selectedSexualOrientations}',
                              );
                            },
                            blurNotifier: _isBlurNotifier,
                          ),
                          CustomSizedBox(height: 20),

                          // Pronouns
                          DropdownFieldWidget(
                            label: 'Select Pronouns',
                            subtitle: 'Select what feels right for you.',
                            selectedValue:
                                (_kycCubit.selectedPronoun == null ||
                                    (_kycCubit.selectedPronoun?.isEmpty ??
                                        false))
                                ? 'Select'
                                : _kycCubit.selectedPronoun,
                            options: DummyConstants.pronouns,
                            selectionType: SelectionType.single,
                            onSelected: (value) {
                              _kycCubit.selectPronouns(value);
                            },
                            blurNotifier: _isBlurNotifier,
                          ),
                          if (widget.isEditMode == true) ...[
                            CustomSizedBox(height: 16),
                            CustomLabelTextField(
                              label: 'Job Title / Occupation',
                              labelStyle: AppTextStyles.bodyLarge(context)
                                  .copyWith(
                                    color: isLightTheme(context)
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                              controller: _kycCubit.jobTitleController,
                              hintText: 'What do you do?',
                              labelColor: isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white,
                              filled: false,
                            ),
                            CustomSizedBox(height: 16),

                            CustomLabelTextField(
                              label: 'Education / School',
                              labelStyle: AppTextStyles.bodyLarge(context)
                                  .copyWith(
                                    color: isLightTheme(context)
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                              controller: _kycCubit.educationController,
                              hintText: 'Where do/did you go to school?',
                              labelColor: isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white,
                              filled: false,
                            ),
                          ],

                          CustomSizedBox(height: 80),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isBlurNotifier,
              builder: (context, isBlurred, child) {
                return IgnorePointer(
                  ignoring: !isBlurred,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isBlurred ? 1 : 0.0,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder(
          bloc: createAccount,
          builder: (context, state) {
            return ContinueButton(
              isLoading: createAccount.state is CreateAccountLoading,
              onTap: () async {
                if (widget.isEditMode == true) {
                  await createAccount.updateProfile();
                  AutoRouter.of(context).pop();
                } else {
                  AutoRouter.of(context).push(const KycDetailsRoute());
                }
              },
              text: widget.isEditMode == true ? 'Done' : 'Continue',
            );
          },
        ),
      ),
    );
  }
}

final createAccount = Di().sl<CreateAccountCubit>();
