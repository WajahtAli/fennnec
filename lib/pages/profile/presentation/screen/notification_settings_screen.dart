import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/notification_settings_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/notification_settings_state.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/notification_item.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/skeletons/notification_item_skeleton.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  late final NotificationSettingsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = Di().sl<NotificationSettingsCubit>();
    cubit.fetchNotificationSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child:
              BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is NotificationSettingsLoading &&
                      cubit.notificationSettingsModel == null) {
                    return Column(
                      children: [
                        CustomAppBar(title: 'Notification Settings'),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: NotificationItemSkeleton(),
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is NotificationSettingsError &&
                      cubit.notificationSettingsModel == null) {
                    return Column(
                      children: [
                        CustomAppBar(title: 'Notification Settings'),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Error loading notification settings',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      CustomAppBar(title: 'Notification Settings'),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 8),

                              ListView.builder(
                                itemCount: cubit.notificationItems.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final item = cubit.notificationItems[index];

                                  return NotificationItem(
                                    title: item.title,
                                    subtitle: item.subtitle,
                                    value: item.value,
                                    onChanged: (value) {
                                      cubit.toggleNotification(index, value);
                                    },
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
                                  await cubit.updateNotificationSettings();
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
