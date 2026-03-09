import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/privacy_permission_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/privacy_permission_state.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/notification_item.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/skeletons/notification_item_skeleton.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class PrivacyPermissionsScreen extends StatefulWidget {
  const PrivacyPermissionsScreen({super.key});

  @override
  State<PrivacyPermissionsScreen> createState() =>
      _PrivacyPermissionsScreenState();
}

class _PrivacyPermissionsScreenState extends State<PrivacyPermissionsScreen> {
  late final PrivacyPermissionCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = Di().sl<PrivacyPermissionCubit>();
    cubit.fetchPrivacyPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child: BlocBuilder<PrivacyPermissionCubit, PrivacyPermissionState>(
            bloc: cubit,
            builder: (context, state) {
              return Column(
                children: [
                  CustomAppBar(title: 'Privacy & Permissions'),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          if (state is PrivacyPermissionLoading &&
                              cubit.privacyPermissionModel == null)
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: NotificationItemSkeleton(),
                            )
                          else
                            ListView.builder(
                              itemCount: cubit.privacyItems.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = cubit.privacyItems[index];

                                return NotificationItem(
                                  title: item.title,
                                  subtitle: item.subtitle,
                                  value: item.value,
                                  onChanged: (val) =>
                                      cubit.togglePrivacy(index, val),
                                );
                              },
                            ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomElevatedButton(
                      icon: cubit.isSubmitting
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: Lottie.asset(
                                Assets.animations.loadingSpinner,
                              ),
                            )
                          : SizedBox.shrink(),
                      text: cubit.isSubmitting ? '' : 'Save Changes',
                      isLoading: cubit.isSubmitting,
                      onTap: cubit.isSubmitting
                          ? () {}
                          : () async {
                              await cubit.updatePrivacyPermission();
                            },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
