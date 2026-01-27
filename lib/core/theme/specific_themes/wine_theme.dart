import 'package:flutter/material.dart';
import '../app_colors.dart';

final ThemeData wineTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.wineBackground,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.winePrimary,
    brightness: Brightness.light,
    surface: AppColors.wineBackground,
    onSurface: AppColors.winePrimary,
    primary: AppColors.winePrimary,
    onPrimary: AppColors.wineOnPrimary,
    outline: AppColors.winePrimary.withValues(alpha: 0.5),
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.winePrimary,
    thumbColor: AppColors.winePrimary,
    overlayColor: AppColors.winePrimary.withValues(alpha: 0.2),
    inactiveTrackColor: AppColors.winePrimary.withValues(alpha: 0.2),
  ),
);

const LinearGradient wineGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.wineBackground, Color(0xFFE0D0AA)],
);
