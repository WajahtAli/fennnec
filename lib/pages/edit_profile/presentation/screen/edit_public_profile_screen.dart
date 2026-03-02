import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/login_state.dart';
import 'package:fennac_app/pages/edit_profile/presentation/widgets/best_shorts_section.dart';
import 'package:fennac_app/pages/edit_profile/presentation/widgets/edit_profile_avatar.dart';
import 'package:fennac_app/pages/edit_profile/presentation/widgets/prompts_section.dart';
import 'package:fennac_app/pages/home/presentation/widgets/group_gallery_widget.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/interest_section_widget.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/interest_selection_bottomsheet.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/lifestyle_section_widget.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/lifestyle_selection_bottomsheet.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/profile_header.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/skeletons/profile_edit_skeleton.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/data/model/prompt_model.dart';
import '../../../create_group/presentation/bloc/cubit/create_group_cubit.dart';

@RoutePage()
class EditPublicProfileScreen extends StatefulWidget {
  const EditPublicProfileScreen({super.key});

  @override
  State<EditPublicProfileScreen> createState() =>
      _EditPublicProfileScreenState();
}

class _EditPublicProfileScreenState extends State<EditPublicProfileScreen> {
  final LoginCubit _loginCubit = Di().sl<LoginCubit>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loginCubit.getSelfInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: BlocBuilder<LoginCubit, LoginState>(
              bloc: _loginCubit,
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Column(
                    children: [
                      const CustomAppBar(title: 'Edit Public Profile'),
                      const ProfileEditSkeleton(),
                    ],
                  );
                }

                final user = _loginCubit.userData?.user;

                return Column(
                  children: [
                    const CustomAppBar(title: 'Edit Public Profile'),
                    EditProfileAvatar(
                      imageUrl: user?.bestShorts?.isNotEmpty == true
                          ? user!.bestShorts!.first
                          : null,
                      onEditTap: () =>
                          _handleEditTap(context, EditableCardType.image),
                    ),
                    const CustomSizedBox(height: 24),
                    ProfileHeader(
                      backgroundColor: isDarkTheme(context)
                          ? ColorPalette.secondary.withValues(alpha: 0.75)
                          : null,
                      showAvatar: false,
                      isEditMode: true,
                    ),
                    const CustomSizedBox(height: 24),
                    BestShortsSection(
                      bestShorts: user?.bestShorts ?? [],
                      onEditTap: () =>
                          _handleEditTap(context, EditableCardType.image),
                    ),
                    LifestyleSectionWidget(
                      userName: user?.firstName ?? 'Your',
                      lifestyles: user?.lifestyleLikes ?? [],
                      onEditTap: () =>
                          _handleEditTap(context, EditableCardType.lifestyle),
                    ),
                    const CustomSizedBox(height: 24),
                    PromptsSection(
                      prompts: _loginCubit.userData?.prompts ?? [],
                      onEditTap: (prompt, isEditMode) {
                        log("isEditMode: $isEditMode");
                        if (isEditMode == false) {
                          Di().sl<KycPromptCubit>().resetAllData();
                          _handleEditTap(
                            context,
                            EditableCardType.prompt,
                            isEditMode: isEditMode,
                          );
                          return;
                        }
                        Di().sl<KycPromptCubit>().resetAllData();
                        log("prim ${_loginCubit.userData?.prompts?.length}");
                        for (Prompt i in _loginCubit.userData?.prompts ?? []) {
                          Di().sl<KycPromptCubit>().addPrompt(
                            AudioPromptData(
                              id: i.id,
                              oldId: i.id,
                              promptText: i.promptTitle?.toString() ?? '',
                              promptAnswer: i.promptAnswer?.toString() ?? '',
                              isCustom: false,
                              waveformData: i.waves,
                              duration: "15:00",
                            ),
                          );
                        }
                        // log(prompt.id.toString());
                        // AudioPromptData audioPromptData = AudioPromptData(
                        //   id: prompt.id,
                        //   oldId: prompt.id,
                        //   promptText: prompt.promptTitle?.toString() ?? '',
                        //   promptAnswer: prompt.promptAnswer?.toString() ?? '',
                        //   isCustom: false,
                        //   waveformData: prompt.waves,
                        //   duration: "15:00",
                        // );
                        // Di().sl<KycPromptCubit>().addPrompt(audioPromptData);
                        _handleEditTap(
                          context,
                          EditableCardType.prompt,
                          isEditMode: isEditMode,
                        );
                      },
                    ),
                    const CustomSizedBox(height: 24),
                    InterestSectionWidget(
                      userName: user?.firstName ?? 'Your',
                      vibes: user?.vibes,
                      onEditTap: () =>
                          _handleEditTap(context, EditableCardType.interest),
                    ),
                    const CustomSizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _handleEditTap(
    BuildContext context,
    EditableCardType editType, {
    bool isEditMode = false,
  }) async {
    switch (editType) {
      case EditableCardType.image:
        await AutoRouter.of(
          context,
        ).push(KycGalleryRoute(isEditMode: true)).then((value) {
          _loginCubit.getSelfInfo();
        });
        break;
      case EditableCardType.prompt:
        Di().sl<CreateGroupCubit>().groupId = "";
        await AutoRouter.of(context).push(
          KycPromptRoute(
            showSkipButton: false,
            isEditMode: isEditMode,
            title: 'Edit Profile Details',
          ),
        );
        if (mounted) {
          _loginCubit.getSelfInfo();
        }
        break;
      case EditableCardType.lifestyle:
        await LifestyleSelectionBottomSheet.show(context);
        if (mounted) {
          _loginCubit.getSelfInfo();
        }
        break;
      case EditableCardType.interest:
        await InterestSelectionBottomSheet.show(context);
        if (mounted) {
          _loginCubit.getSelfInfo();
        }
        break;
      case EditableCardType.audio:
        AutoRouter.of(context).push(
          KycPromptRoute(
            showSkipButton: false,
            isEditMode: true,
            title: "Edit Profile Prompts",
          ),
        );
        break;
    }
  }
}
