import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';

class AppStyle {
  static const TextStyle kDefaultTextStyle = TextStyle(fontFamily: FontFamily.notoSansJP);

  static TextTheme appTextTheme = TextTheme(
    displayLarge: kDefaultTextStyle.copyWith(
      fontSize: 57, // Suggested size for displayLarge in Material 3
      fontWeight: FontWeight.w400,
    ),
    displayMedium: kDefaultTextStyle.copyWith(
      fontSize: 45, // Suggested size for displayMedium in Material 3
      fontWeight: FontWeight.w400,
    ),
    displaySmall: kDefaultTextStyle.copyWith(
      fontSize: 36, // Suggested size for displaySmall in Material 3
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: kDefaultTextStyle.copyWith(
      fontSize: 32, // Suggested size for headlineLarge in Material 3
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: kDefaultTextStyle.copyWith(
      fontSize: 28, // Suggested size for headlineMedium in Material 3
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: kDefaultTextStyle.copyWith(
      fontSize: 24, // Suggested size for headlineSmall in Material 3
      fontWeight: FontWeight.w400,
    ),
    titleLarge: kDefaultTextStyle.copyWith(
      fontSize: 22, // Suggested size for titleLarge in Material 3
      fontWeight: FontWeight.w400,
    ),
    titleMedium: kDefaultTextStyle.copyWith(
      fontSize: 16, // Suggested size for titleMedium in Material 3
      fontWeight: FontWeight.w500,
    ),
    titleSmall: kDefaultTextStyle.copyWith(
      fontSize: 14, // Suggested size for titleSmall in Material 3
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: kDefaultTextStyle.copyWith(
      fontSize: 16, // Suggested size for bodyLarge in Material 3
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: kDefaultTextStyle.copyWith(
      fontSize: 14, // Suggested size for bodyMedium in Material 3
      fontWeight: FontWeight.w400,
    ),
    bodySmall: kDefaultTextStyle.copyWith(
      fontSize: 12, // Suggested size for bodySmall in Material 3
      fontWeight: FontWeight.w400,
    ),
    labelLarge: kDefaultTextStyle.copyWith(
      fontSize: 14, // Suggested size for labelLarge in Material 3
      fontWeight: FontWeight.w500,
    ),
    labelMedium: kDefaultTextStyle.copyWith(
      fontSize: 12, // Suggested size for labelMedium in Material 3
      fontWeight: FontWeight.w500,
    ),
    labelSmall: kDefaultTextStyle.copyWith(
      fontSize: 11, // Suggested size for labelSmall in Material 3
      fontWeight: FontWeight.w500,
    ),
  );
}