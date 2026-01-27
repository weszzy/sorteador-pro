import 'package:flutter/material.dart';
import '../app_colors.dart';

final ThemeData classicTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.classicBgStart,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.classicPrimary,
    brightness: Brightness.dark,
    surface: AppColors.classicSurface,
    onSurface: Colors.white,
    primary: AppColors.classicPrimary,
    onPrimary: AppColors.classicOnPrimary,
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.classicPrimary,
    thumbColor: AppColors.classicPrimary,
    overlayColor: AppColors.classicPrimary.withValues(alpha: 0.2),
  ),
);

const LinearGradient classicGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.classicBgStart, AppColors.classicPrimary],
);
