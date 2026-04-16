import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../state/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
    : super(const SettingsState(themeMode: ThemeMode.dark, isDarkMode: true)) {
    loadTheme();
  }

  static const _legacyThemeKey = 'isDarkMode';
  static const _themeModeKey = 'themeMode';

  static const _themeModeDark = 'dark';
  static const _themeModeLight = 'light';
  static const _themeModeSystem = 'system';

  static Future<ThemeMode> getSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final storedThemeMode = prefs.getString(_themeModeKey);

    if (storedThemeMode != null) {
      switch (storedThemeMode) {
        case _themeModeDark:
          return ThemeMode.dark;
        case _themeModeLight:
          return ThemeMode.light;
        case _themeModeSystem:
          return ThemeMode.system;
        default:
          return ThemeMode.light;
      }
    }

    final isDark = prefs.getBool(_legacyThemeKey) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final storedThemeMode = prefs.getString(_themeModeKey);

    if (storedThemeMode != null) {
      final themeMode = _themeModeFromString(storedThemeMode);
      emit(
        SettingsState(
          themeMode: themeMode,
          isDarkMode: themeMode == ThemeMode.dark,
        ),
      );
      return;
    }

    // Backward compatibility for previously stored boolean preference.
    final isDark = prefs.getBool(_legacyThemeKey) ?? false;
    emit(
      SettingsState(
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        isDarkMode: isDark,
      ),
    );
  }

  Future<void> toggleTheme(bool isDark) async {
    await setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, _themeModeToString(themeMode));
    await prefs.setBool(_legacyThemeKey, themeMode == ThemeMode.dark);

    emit(
      SettingsState(
        themeMode: themeMode,
        isDarkMode: themeMode == ThemeMode.dark,
      ),
    );
  }

  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case _themeModeDark:
        return ThemeMode.dark;
      case _themeModeLight:
        return ThemeMode.light;
      case _themeModeSystem:
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return _themeModeDark;
      case ThemeMode.light:
        return _themeModeLight;
      case ThemeMode.system:
        return _themeModeSystem;
    }
  }
}
