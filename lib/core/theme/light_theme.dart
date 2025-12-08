import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,

  colorScheme: const ColorScheme.light(
    primary: AppColors.darkOlive,
    onPrimary: AppColors.offWhite,
    surface: AppColors.offWhite,
    onSurface: AppColors.darkOlive,
    outline: AppColors.offWhite,
  ),

  scaffoldBackgroundColor: AppColors.lightBgStart,

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.darkOlive,
    thumbColor: AppColors.darkOlive,
    overlayColor: AppColors.darkOlive.withOpacity(0.2),
  ),
);
