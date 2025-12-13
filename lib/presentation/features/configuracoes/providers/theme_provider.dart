import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/providers.dart';
import '../../../../core/theme/app_theme_types.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeType>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeNotifier(prefs);
});

class ThemeNotifier extends StateNotifier<AppThemeType> {
  final SharedPreferences _prefs;
  static const _key = 'app_theme_type';

  ThemeNotifier(this._prefs) : super(AppThemeType.classic) {
    _loadTheme();
  }

  void _loadTheme() {
    final savedString = _prefs.getString(_key);
    if (savedString != null) {
      try {
        state = AppThemeType.values.firstWhere(
          (e) => e.toString() == savedString,
        );
      } catch (_) {
        state = AppThemeType.classic;
      }
    }
  }

  void setTheme(AppThemeType type) {
    state = type;
    _prefs.setString(_key, type.toString());
  }
}
