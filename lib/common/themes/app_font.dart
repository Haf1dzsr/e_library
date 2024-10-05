import 'package:e_library/common/themes/app_color.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.bold,
    fontSize: 32,
    color: AppColor.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColor.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColor.textPrimary,
  );

  static const TextStyle subtitleLarge = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColor.textSecondary,
  );

  static const TextStyle subtitleMedium = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColor.textSecondary,
  );

  static const TextStyle bodyTextLarge = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppColor.textPrimary,
  );

  static const TextStyle bodyTextMedium = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppColor.textPrimary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: AppColor.textSecondary,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: 'MaisonNeue',
    fontWeight: FontWeight.normal,
    fontSize: 10,
    color: AppColor.textSecondary,
  );
}
