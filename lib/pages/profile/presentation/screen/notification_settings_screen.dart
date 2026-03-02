import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/profile_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/profile_state.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/notification_item.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = Di().sl<ProfileCubit>();

    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: cubit,
            builder: (context, state) {
              return Column(
                children: [
                  CustomAppBar(title: 'Notification Settings'),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),

                          BlocBuilder<ProfileCubit, ProfileState>(
                            bloc: cubit,
                            builder: (context, state) {
                              return ListView.builder(
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
                      text: 'Save Changes',
                      onTap: () {
                        Navigator.pop(context);
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
