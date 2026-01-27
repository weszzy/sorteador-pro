import 'package:flutter/material.dart';
import '../app_colors.dart';

final ThemeData indigoTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.indigoBackground,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.indigoPrimary,
    brightness: Brightness.light,
    surface: AppColors.indigoSurface,
    onSurface: AppColors.indigoPrimary,
    primary: AppColors.indigoPrimary,
    onPrimary: AppColors.indigoOnPrimary,
    outline: AppColors.indigoPrimary.withValues(alpha: 0.5),
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.indigoPrimary,
    thumbColor: AppColors.indigoPrimary,
    overlayColor: AppColors.indigoPrimary.withValues(alpha: 0.2),
    inactiveTrackColor: AppColors.indigoPrimary.withValues(alpha: 0.2),
  ),
);

const LinearGradient indigoGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.indigoBackground, AppColors.indigoBackground],
);
