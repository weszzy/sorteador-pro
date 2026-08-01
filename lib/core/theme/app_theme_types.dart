enum AppThemeType { classic, indigo }

extension AppThemeTypeExtension on AppThemeType {
  String get label {
    switch (this) {
      case AppThemeType.classic:
        return 'Clássico';
      case AppThemeType.indigo:
        return 'Índigo';
    }
  }
}
