import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/create_group_state.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/create_group_content.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class CreateGroupScreen extends StatefulWidget {
  final bool isEditMode;

  const CreateGroupScreen({super.key, this.isEditMode = false});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final createGroupContentKey = GlobalKey<State>();

  @override
  void initState() {
    super.initState();

    if (!widget.isEditMode) {
      final createGroupCubit = Di().sl<CreateGroupCubit>();
      createGroupCubit.resetAllData();
      Di().sl<ImagePickerCubit>().clearAllMedia();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = Di().sl<CreateGroupCubit>();

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorPalette.secondary,
        body: MovableBackground(
          backgroundType: MovableBackgroundType.dark,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title: widget.isEditMode
                      ? 'Edit Group Details'
                      : 'Create a Group',
                  titleStyle: AppTextStyles.h4(
                    context,
                  ).copyWith(letterSpacing: 0.2, fontWeight: FontWeight.bold),
                  action: AppInkWell(
                    onTap: () {
                      AutoRouter.of(context).push(
                        FindGroupRoute(
                          findGroupScreenType:
                              FindGroupScreenType.qrProfileCode,
                          isFromCreateGroup: true,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.qr_code_2,
                      color: isLightTheme(context)
                          ? ColorPalette.primary
                          : Colors.white,
                    ),
                  ),
                ),

                CreateGroupContent(isEditMode: widget.isEditMode),
              ],
            ),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder(
          bloc: createGroupCubit,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: CustomElevatedButton(
                text: state is CreateGroupLoading
                    ? ''
                    : widget.isEditMode
                    ? 'Update Group Details'
                    : 'Add Group Photos/Videos',
                icon: state is CreateGroupLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: LottieBuilder.asset(
                          Assets.animations.loadingSpinner,
                        ),
                      )
                    : null,
                onTap: () {
                  if (widget.isEditMode == true) {
                    if (!createGroupCubit
                        .canCurrentUserUpdateAnythingOnDetailsScreen()) {
                      VxToast.show(
                        message:
                            'You do not have permission to update this group.',
                      );
                      return;
                    }
                    createGroupCubit.updateGroupWithChangedFields(
                      groupId:
                          Di().sl<MyGroupCubit>().myGroupModel?.data?.id ?? '',
                    );
                  } else {
                    final contactListCubit = Di().sl<ContactListCubit>();
                    final createGroupCubit = Di().sl<CreateGroupCubit>();

                    if (contactListCubit.selectedMembers.isEmpty) {
                      VxToast.show(
                        message:
                            'Please select at least 2 members to create a group.',
                      );
                    } else if (createGroupCubit.groupTitle.trim().isEmpty) {
                      VxToast.show(message: 'Group title is required');
                    } else if (createGroupCubit.groupBio.trim().isEmpty) {
                      VxToast.show(message: 'Short bio is required');
                    } else if (createGroupCubit.selectedInterests.isEmpty ||
                        createGroupCubit.fitsForGroup.trim().isEmpty) {
                      VxToast.show(
                        message: 'Please describe what fits your group well',
                      );
                    } else {
                      AutoRouter.of(context).push(
                        DistanceRoute(
                          isEditMode: widget.isEditMode,
                          needPickLocation: true,
                        ),
                      );
                    }
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

final createGroupCubit = Di().sl<CreateGroupCubit>();
