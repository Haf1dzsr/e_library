import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_font.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColor.primary,
  textTheme: const TextTheme(
    headlineLarge: AppTextStyle.headlineLarge,
    headlineMedium: AppTextStyle.headlineMedium,
    headlineSmall: AppTextStyle.headlineSmall,
    titleLarge: AppTextStyle.subtitleLarge,
    titleMedium: AppTextStyle.subtitleMedium,
    bodyLarge: AppTextStyle.bodyTextLarge,
    bodyMedium: AppTextStyle.bodyTextMedium,
    labelLarge: AppTextStyle.button,
    labelSmall: AppTextStyle.caption,
    titleSmall: AppTextStyle.overline,
  ),
  colorScheme: const ColorScheme(
    primary: AppColor.primary,
    secondary: AppColor.secondary,
    tertiary: AppColor.accent,
    surface: AppColor.surface,
    error: AppColor.error,
    onErrorContainer: AppColor.onError,
    onPrimary: AppColor.onPrimary,
    onSecondary: AppColor.onSecondary,
    onSurface: AppColor.onSurface,
    onError: AppColor.onError,
    brightness: Brightness.light,
  ),
);
