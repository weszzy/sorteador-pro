import 'package:flutter/material.dart';
import '../app_colors.dart';

final ThemeData mochaTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.mochaBackground,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.mochaPrimary,
    brightness: Brightness.light,
    surface: AppColors.mochaSurface,
    onSurface: AppColors.mochaPrimary,
    primary: AppColors.mochaPrimary,
    onPrimary: AppColors.mochaOnPrimary,
    outline: AppColors.mochaPrimary.withValues(alpha: 0.5),
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.mochaPrimary,
    thumbColor: AppColors.mochaPrimary,
    overlayColor: AppColors.mochaPrimary.withValues(alpha: 0.2),
    inactiveTrackColor: AppColors.mochaPrimary.withValues(alpha: 0.2),
  ),
);

const LinearGradient mochaGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.mochaBackground, AppColors.mochaBackground],
);
