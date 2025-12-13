import 'package:flutter/material.dart';
import '../app_colors.dart';

final ThemeData matchaTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.matchaBackground,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.matchaPrimary,
    brightness: Brightness.light,
    surface: AppColors.matchaBackground,
    onSurface: AppColors.matchaPrimary,
    primary: AppColors.matchaPrimary,
    onPrimary: AppColors.matchaBackground,
    outline: AppColors.matchaPrimary.withOpacity(0.5),
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.matchaPrimary,
    thumbColor: AppColors.matchaPrimary,
    overlayColor: AppColors.matchaPrimary.withOpacity(0.2),
    inactiveTrackColor: AppColors.matchaPrimary.withOpacity(0.2),
  ),
);

const LinearGradient matchaGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.matchaBackground, Color(0xFFE0D4BC)],
);
