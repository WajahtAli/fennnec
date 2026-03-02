import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/settings_cubit.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/theme/app_colors.dart';
import '../widgets/notification_item.dart';

@RoutePage()
class AppearenceScreen extends StatelessWidget {
  const AppearenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        child: Column(
          children: [
            CustomAppBar(title: 'App Appearence'),
            BlocBuilder(
              bloc: settingsCubit,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: NotificationItem(
                    title: 'Change App Theme',
                    subtitle: 'Change theme',
                    value: settingsCubit.state.isDarkMode,
                    onChanged: (v) {
                      final themeSwitcher = ThemeSwitcher.of(context);
                      themeSwitcher.changeTheme(
                        theme: v ? darkTheme(context) : lightTheme(context),
                        isReversed: !v,
                        offset: const Offset(1, 0),
                      );
                      settingsCubit.toggleTheme(v);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final SettingsCubit settingsCubit = Di().sl<SettingsCubit>();
