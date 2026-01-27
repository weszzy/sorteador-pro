import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/providers.dart';
import 'presentation/features/configuracoes/providers/theme_provider.dart';
import 'presentation/features/splash/screens/splash_screen.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('historico');

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const SorteadorApp(),
    ),
  );
}

class SorteadorApp extends ConsumerWidget {
  const SorteadorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeType = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Sorteador Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(currentThemeType),
      home: const SplashScreen(),
      builder: (context, child) {
        return ToastificationWrapper(child: child!);
      },
    );
  }
}
