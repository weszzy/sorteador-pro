import 'package:flutter/material.dart';
import 'app_theme_types.dart';
import 'premium_tokens.dart';

import 'specific_themes/classic_theme.dart';
import 'specific_themes/wine_theme.dart';
import 'specific_themes/mocha_theme.dart';
import 'specific_themes/indigo_theme.dart';

class AppTheme {
  static ThemeData getTheme(AppThemeType type) {
    ThemeData theme;
    switch (type) {
      case AppThemeType.classic:
        theme = classicTheme;
        break;
      case AppThemeType.wine:
        theme = wineTheme;
        break;
      case AppThemeType.mocha:
        theme = mochaTheme;
        break;
      case AppThemeType.indigo:
        theme = indigoTheme;
        break;
    }
    final colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface.withValues(alpha: 0.86),
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          color: colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface.withValues(alpha: 0.74),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PremiumTokens.radiusSm),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.16),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PremiumTokens.radiusSm),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.16),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PremiumTokens.radiusSm),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
        ),
        labelStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.68),
        ),
        helperStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.50),
        ),
        prefixIconColor: colorScheme.primary,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: colorScheme.outline.withValues(alpha: 0.16)),
          ),
        ),
      ),
      chipTheme: theme.chipTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PremiumTokens.radiusSm),
        ),
        side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.12)),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static LinearGradient getGradient(AppThemeType type) {
    switch (type) {
      case AppThemeType.classic:
        return classicGradient;
      case AppThemeType.wine:
        return wineGradient;
      case AppThemeType.mocha:
        return mochaGradient;
      case AppThemeType.indigo:
        return indigoGradient;
    }
  }
}
