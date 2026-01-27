import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme_types.dart';

class FluidBackground extends StatelessWidget {
  final AppThemeType type;
  final Widget child;

  const FluidBackground({super.key, required this.type, required this.child});

  @override
  Widget build(BuildContext context) {
    final config = _getColors(type);

    return Stack(
      children: [
        Stack(
          children: [
            Container(color: config.base),

            Positioned(
              top: -150,
              left: -150,
              child: _buildBlob(color: config.blob1, size: 500),
            ),

            Positioned(
              bottom: -200,
              right: -100,
              child: _buildBlob(color: config.blob2, size: 600),
            ),

            Positioned(
              top: 200,
              right: -200,
              child: _buildBlob(color: config.blob3, size: 550),
            ),

            Positioned(
              bottom: 100,
              left: -150,
              child: _buildBlob(
                color: config.blob1.withValues(alpha: 0.5),
                size: 300,
              ),
            ),
          ],
        ),

        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 98.0, sigmaY: 98.0),
            child: Container(color: Colors.transparent),
          ),
        ),

        SizedBox.expand(child: child),
      ],
    );
  }

  Widget _buildBlob({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }

  _FluidPalette _getColors(AppThemeType type) {
    switch (type) {
      case AppThemeType.classic:
        return _FluidPalette(
          base: const Color(0xFF1F2235),
          blob1: const Color(0xFFE3A419).withValues(alpha: 0.15),
          blob2: const Color(0xFF151725).withValues(alpha: 0.8),
          blob3: const Color(0xFF2A2F45).withValues(alpha: 0.5),
        );

      case AppThemeType.wine:
        return _FluidPalette(
          base: const Color(0xFFEFDFBB),
          blob1: const Color(0xFF722F37).withValues(alpha: 0.85),
          blob2: const Color(0xFF231123).withValues(alpha: 0.6),
          blob3: const Color(0xFFFFFFFF).withValues(alpha: 0.8),
        );

      case AppThemeType.mocha:
        return _FluidPalette(
          base: const Color(0xFFE0D0B6),
          blob1: const Color(0xFF4B3935).withValues(alpha: 0.85),
          blob2: const Color(0xFF4B3935).withValues(alpha: 0.5),
          blob3: const Color(0xFFF0E7D5).withValues(alpha: 0.6),
        );

      case AppThemeType.indigo:
        return _FluidPalette(
          base: const Color(0xFFCFD3DC),
          blob1: const Color(0xFF212842).withValues(alpha: 0.85),
          blob2: const Color(0xFF212842).withValues(alpha: 0.5),
          blob3: const Color(0xFFF0F4F8).withValues(alpha: 0.6),
        );
    }
  }
}

class _FluidPalette {
  final Color base;
  final Color blob1;
  final Color blob2;
  final Color blob3;

  _FluidPalette({
    required this.base,
    required this.blob1,
    required this.blob2,
    required this.blob3,
  });
}
