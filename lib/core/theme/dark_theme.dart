import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.mongoose,
    onPrimary: AppColors.darkTextOnPrimary,
    surface: AppColors.darkBgStart,
    onSurface: AppColors.mongoose,
    outline: AppColors.mongoose,
  ),

  scaffoldBackgroundColor: AppColors.darkBgStart,

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.mongoose,
    thumbColor: AppColors.mongoose,
    overlayColor: AppColors.mongoose.withOpacity(0.2),
  ),
);
