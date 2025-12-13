import 'package:flutter/material.dart';
import 'app_theme_types.dart';

import 'specific_themes/classic_theme.dart';
import 'specific_themes/ocean_theme.dart';
import 'specific_themes/matcha_theme.dart';
import 'specific_themes/wine_theme.dart';

class AppTheme {
  static ThemeData getTheme(AppThemeType type) {
    switch (type) {
      case AppThemeType.classic:
        return classicTheme;
      case AppThemeType.ocean:
        return oceanTheme;
      case AppThemeType.matcha:
        return matchaTheme;
      case AppThemeType.wine:
        return wineTheme;
    }
  }

  static LinearGradient getGradient(AppThemeType type) {
    switch (type) {
      case AppThemeType.classic:
        return classicGradient;
      case AppThemeType.ocean:
        return oceanGradient;
      case AppThemeType.matcha:
        return matchaGradient;
      case AppThemeType.wine:
        return wineGradient;
    }
  }
}
