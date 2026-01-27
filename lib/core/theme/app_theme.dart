import 'package:flutter/material.dart';
import 'app_theme_types.dart';

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
    return theme.copyWith(
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
