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
                color: config.blob1.withOpacity(0.5),
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
          colors: [color, color.withOpacity(0.0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }

  _FluidPalette _getColors(AppThemeType type) {
    switch (type) {
      case AppThemeType.classic:
        return _FluidPalette(
          base: const Color(0xFF15171E),
          blob1: const Color(0xFFD4AF37).withOpacity(0.6),
          blob2: const Color(0xFF3A3845),
          blob3: const Color(0xFF2A2D3E),
        );

      case AppThemeType.matcha:
        return _FluidPalette(
          base: const Color(0xFFF2E8D5),
          blob1: const Color(0xFF5C6652).withOpacity(0.8),
          blob2: const Color(0xFF7A876D).withOpacity(0.5),
          blob3: const Color(0xFFFFFDF5).withOpacity(0.9),
        );

      case AppThemeType.ocean:
        return _FluidPalette(
          base: const Color(0xFF03045E),
          blob1: const Color(0xFF00B4D8).withOpacity(0.7),
          blob2: const Color(0xFF0077B6),
          blob3: const Color(0xFF90E0EF).withOpacity(0.5),
        );

      case AppThemeType.wine:
        return _FluidPalette(
          base: const Color(0xFFEFDFBB),
          blob1: const Color(0xFF722F37).withOpacity(0.85),
          blob2: const Color(0xFF231123).withOpacity(0.6),
          blob3: const Color(0xFFFFFFFF).withOpacity(0.8),
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
