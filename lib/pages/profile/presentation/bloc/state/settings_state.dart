import 'package:flutter/material.dart';

class SettingsState {
  final ThemeMode themeMode;
  final bool isDarkMode;

  const SettingsState({required this.themeMode, required this.isDarkMode});

  SettingsState copyWith({ThemeMode? themeMode, bool? isDarkMode}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
