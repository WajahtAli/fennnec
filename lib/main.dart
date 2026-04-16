import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/core/initialization/app_initalization.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';

void main() async {
  try {
    await AppInitalizer.init();
    final savedThemeMode = await SettingsCubit.getSavedThemeMode();
    runApp(MyApp(initialThemeMode: savedThemeMode));
  } catch (error, stackTrace) {
    debugPrint('Initialization failed: $error');
    debugPrint('Stack trace: $stackTrace');
    runApp(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Initialization error'))),
      ),
    );
  }
}
