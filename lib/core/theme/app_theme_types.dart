enum AppThemeType { classic, ocean, matcha, wine }

extension AppThemeTypeExtension on AppThemeType {
  String get label {
    switch (this) {
      case AppThemeType.classic:
        return 'Clássico';
      case AppThemeType.ocean:
        return 'Oceano';
      case AppThemeType.matcha:
        return 'Matcha';
      case AppThemeType.wine:
        return 'Vinho';
    }
  }
}
