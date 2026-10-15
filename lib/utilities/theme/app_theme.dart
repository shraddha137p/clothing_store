import 'package:clothing_store/utilities/theme/app_color.dart';
import 'package:clothing_store/utilities/theme/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      splashColor: Colors.transparent,
      useMaterial3: true,
      colorScheme: lightColorScheme,
      canvasColor: lightColorScheme.surface,
      brightness: lightColorScheme.brightness,
      textTheme: AppStyle.appTextTheme.apply(
        bodyColor: lightColorScheme.onSurface,
        displayColor: lightColorScheme.onSurface,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: lightColorScheme.surface,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: lightColorScheme.inverseSurface);
            } else {
              return IconThemeData(color: lightColorScheme.inverseSurface.withValues(alpha: 0.55));
            }
          },
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppStyle.appTextTheme.bodyLarge?.copyWith(color: lightColorScheme.inverseSurface);
            } else {
              return AppStyle.appTextTheme.bodyLarge?.copyWith(color: lightColorScheme.inverseSurface.withValues(alpha: 0.55));
            }
          },
        ),
      ),
      scaffoldBackgroundColor: lightColorScheme.surface,
    );
  }
}
