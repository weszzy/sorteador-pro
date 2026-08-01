enum AppThemeType { classic, wine, mocha, indigo }

extension AppThemeTypeExtension on AppThemeType {
  String get label {
    switch (this) {
      case AppThemeType.classic:
        return 'Clássico';
      case AppThemeType.wine:
        return 'Vinho';
      case AppThemeType.mocha:
        return 'Mocha';
      case AppThemeType.indigo:
        return 'Índigo';
    }
  }
}
