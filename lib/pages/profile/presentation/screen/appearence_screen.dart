import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/settings_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/settings_state.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/theme/app_colors.dart';
import '../widgets/notification_item.dart';

@RoutePage()
class AppearenceScreen extends StatefulWidget {
  const AppearenceScreen({super.key});

  @override
  State<AppearenceScreen> createState() => _AppearenceScreenState();
}

class _AppearenceScreenState extends State<AppearenceScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (!mounted || settingsCubit.state.themeMode != ThemeMode.system) {
      return;
    }

    final themeSwitcher = ThemeSwitcher.of(context);
    themeSwitcher.changeTheme(
      theme: _systemTheme(context),
      offset: const Offset(1, 0),
    );
  }

  ThemeData _systemTheme(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark
        ? darkTheme(context)
        : lightTheme(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        child: Column(
          children: [
            CustomAppBar(title: 'App Appearence'),
            BlocBuilder<SettingsCubit, SettingsState>(
              bloc: settingsCubit,
              builder: (context, state) {
                final isSystemTheme = state.themeMode == ThemeMode.system;

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      NotificationItem(
                        title: 'Use System Default',
                        subtitle:
                            'Automatically match your device light/dark mode',
                        value: isSystemTheme,
                        onChanged: (v) {
                          if (!v) {
                            final isDark = settingsCubit.state.isDarkMode;
                            final themeSwitcher = ThemeSwitcher.of(context);
                            themeSwitcher.changeTheme(
                              theme: isDark
                                  ? darkTheme(context)
                                  : lightTheme(context),
                              isReversed: !isDark,
                              offset: const Offset(1, 0),
                            );
                            settingsCubit.setThemeMode(
                              isDark ? ThemeMode.dark : ThemeMode.light,
                            );
                            return;
                          }

                          final themeSwitcher = ThemeSwitcher.of(context);
                          themeSwitcher.changeTheme(
                            theme: _systemTheme(context),
                            offset: const Offset(1, 0),
                          );
                          settingsCubit.setThemeMode(ThemeMode.system);
                        },
                      ),
                      IgnorePointer(
                        ignoring: isSystemTheme,
                        child: Opacity(
                          opacity: isSystemTheme ? 0.45 : 1,
                          child: NotificationItem(
                            title: 'Change App Theme',
                            subtitle: isSystemTheme
                                ? 'Disabled while using system default'
                                : 'Change theme',
                            value: settingsCubit.state.isDarkMode,
                            showDivider: false,
                            onChanged: (v) {
                              final themeSwitcher = ThemeSwitcher.of(context);
                              themeSwitcher.changeTheme(
                                theme: v
                                    ? darkTheme(context)
                                    : lightTheme(context),
                                isReversed: !v,
                                offset: const Offset(1, 0),
                              );
                              settingsCubit.setThemeMode(
                                v ? ThemeMode.dark : ThemeMode.light,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
