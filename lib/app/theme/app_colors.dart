import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'text_styles.dart';

// Unified color palette based on Figma
class ColorPalette {
  static Color primary = HexColor("#5F00DB");
  static Color secondary = HexColor("#16003F");
  static Color white = HexColor("#EEF6FF");
  static Color black = HexColor("#000000");
  static Color blackWithOpacity = HexColor("#111111BF");
  static Color cardBlack = HexColor("#222222");
  static Color green = HexColor("#3ADC60");
  static Color greenDark = HexColor("#1E382B");
  static Color error = HexColor("#FF4E4E");
  static Color textSecondary = HexColor("#CCCCCC");
  static Color textGrey = HexColor("#EEEEEE");
  static Color textPrimary = HexColor("#FFFFFF");
  static Color grey = HexColor("#44444480");
  static Color border = HexColor("#888888");
}

class ColorPaletteDark {
  static Color primary = ColorPalette.primary;
  static Color secondary = ColorPalette.secondary;
  static Color white = ColorPalette.white;
  static Color black = ColorPalette.black;
  static Color blackWithOpacity = ColorPalette.blackWithOpacity;
  static Color cardBlack = ColorPalette.cardBlack;
  static Color green = ColorPalette.green;
  static Color greenDark = ColorPalette.greenDark;
  static Color error = ColorPalette.error;
  static Color textSecondary = ColorPalette.textSecondary;
  static Color textGrey = ColorPalette.textGrey;
  static Color textPrimary = ColorPalette.textPrimary;
  static Color grey = ColorPalette.grey;
  static Color border = ColorPalette.border;
}

ThemeData lightTheme(BuildContext context) {
  final base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: ColorPalette.primary,
      onPrimary: ColorPalette.white,
      secondary: ColorPalette.greenDark,
      onSecondary: ColorPalette.white,
      error: ColorPalette.error,
      onError: ColorPalette.white,
      surface: ColorPalette.cardBlack,
      onSurface: ColorPalette.textPrimary,
    ),
    scaffoldBackgroundColor: ColorPalette.white,
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.bodyLarge(context),
      bodyMedium: AppTextStyles.bodyRegular(context),
      bodySmall: AppTextStyles.bodySmall(context),
      headlineLarge: AppTextStyles.h1(context),
      headlineMedium: AppTextStyles.h2(context),
      headlineSmall: AppTextStyles.h6(context),
      displayLarge: AppTextStyles.h1Large(context),
      displayMedium: AppTextStyles.h2(context),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: ColorPaletteDark.primary,
      onPrimary: ColorPaletteDark.white,
      secondary: ColorPaletteDark.secondary,
      onSecondary: ColorPaletteDark.white,
      error: ColorPaletteDark.error,
      onError: ColorPaletteDark.white,
      surface: ColorPaletteDark.cardBlack,
      onSurface: ColorPaletteDark.textPrimary,
    ),
    scaffoldBackgroundColor: ColorPaletteDark.blackWithOpacity,
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.bodyLarge(context),
      bodyMedium: AppTextStyles.bodyRegular(context),
      bodySmall: AppTextStyles.bodySmall(context),
      headlineLarge: AppTextStyles.h1(context),
      headlineMedium: AppTextStyles.h2(context),
      headlineSmall: AppTextStyles.h6(context),
      displayLarge: AppTextStyles.h1Large(context),
      displayMedium: AppTextStyles.h2(context),
    ),
  );
}
