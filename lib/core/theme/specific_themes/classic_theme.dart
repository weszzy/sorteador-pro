import 'package:flutter/material.dart';
import '../premium_tokens.dart';

final ThemeData classicTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: PremiumTokens.ink,

  colorScheme: ColorScheme.fromSeed(
    seedColor: PremiumTokens.gold,
    brightness: Brightness.dark,
    surface: PremiumTokens.inkSoft,
    onSurface: PremiumTokens.cream,
    primary: PremiumTokens.gold,
    onPrimary: PremiumTokens.ink,
    outline: PremiumTokens.line,
    secondary: PremiumTokens.pitch,
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: PremiumTokens.gold,
    thumbColor: PremiumTokens.gold,
    overlayColor: PremiumTokens.gold.withValues(alpha: 0.16),
    inactiveTrackColor: PremiumTokens.cream.withValues(alpha: 0.12),
  ),
);

const LinearGradient classicGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [PremiumTokens.ink, PremiumTokens.goldDeep],
);
