import 'package:flutter/material.dart';
import '../app_colors.dart';

final ThemeData oceanTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.oceanBgStart,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.oceanPrimary,
    brightness: Brightness.dark,
    surface: AppColors.oceanSurface,
    primary: AppColors.oceanPrimary,
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.oceanPrimary,
    thumbColor: AppColors.oceanPrimary,
    overlayColor: AppColors.oceanPrimary.withOpacity(0.2),
  ),
);

const LinearGradient oceanGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [AppColors.oceanBgStart, AppColors.oceanBgEnd],
);
