import 'package:flutter/material.dart';

import '../../core/theme/app_theme_types.dart';
import '../../core/theme/premium_tokens.dart';

class FluidBackground extends StatelessWidget {
  final AppThemeType type;
  final Widget child;

  const FluidBackground({super.key, required this.type, required this.child});

  @override
  Widget build(BuildContext context) {
    final config = _getColors(type);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [config.top, config.base, config.bottom],
        ),
      ),
      child: CustomPaint(
        painter: _PitchLinesPainter(
          lineColor: config.line,
          accentColor: config.accent,
        ),
        child: SizedBox.expand(child: child),
      ),
    );
  }

  _FluidPalette _getColors(AppThemeType type) {
    switch (type) {
      case AppThemeType.classic:
        return _FluidPalette(
          base: PremiumTokens.ink,
          top: const Color(0xFF151B24),
          bottom: const Color(0xFF070A0F),
          line: PremiumTokens.cream.withValues(alpha: 0.035),
          accent: PremiumTokens.pitch.withValues(alpha: 0.14),
        );

      case AppThemeType.wine:
        return _FluidPalette(
          base: const Color(0xFFF6E8C9),
          top: const Color(0xFFFFF7E6),
          bottom: const Color(0xFFE6D0A4),
          line: const Color(0xFF5D0D18).withValues(alpha: 0.045),
          accent: const Color(0xFF5D0D18).withValues(alpha: 0.08),
        );

      case AppThemeType.mocha:
        return _FluidPalette(
          base: const Color(0xFFE8DAC4),
          top: const Color(0xFFF8F0E1),
          bottom: const Color(0xFFD3BDA0),
          line: const Color(0xFF4B3935).withValues(alpha: 0.050),
          accent: const Color(0xFF4B3935).withValues(alpha: 0.07),
        );

      case AppThemeType.indigo:
        return _FluidPalette(
          base: const Color(0xFFDDE4EC),
          top: const Color(0xFFF7FAFD),
          bottom: const Color(0xFFC6D0DD),
          line: const Color(0xFF212842).withValues(alpha: 0.045),
          accent: const Color(0xFF212842).withValues(alpha: 0.07),
        );
    }
  }
}

class _PitchLinesPainter extends CustomPainter {
  final Color lineColor;
  final Color accentColor;

  const _PitchLinesPainter({
    required this.lineColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final accentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    final field = RRect.fromRectAndRadius(
      Rect.fromLTWH(18, 72, size.width - 36, size.height - 132),
      const Radius.circular(32),
    );

    canvas.drawRRect(field, linePaint);
    canvas.drawLine(
      Offset(size.width / 2, 72),
      Offset(size.width / 2, size.height - 60),
      linePaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.43),
      62,
      linePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.18),
      130,
      accentPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.82),
      96,
      accentPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PitchLinesPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.accentColor != accentColor;
  }
}

class _FluidPalette {
  final Color base;
  final Color top;
  final Color bottom;
  final Color line;
  final Color accent;

  const _FluidPalette({
    required this.base,
    required this.top,
    required this.bottom,
    required this.line,
    required this.accent,
  });
}
