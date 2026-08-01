import 'package:flutter/material.dart';

import '../../core/theme/premium_tokens.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double opacity;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.opacity = 0.2,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final radius =
        borderRadius ?? BorderRadius.circular(PremiumTokens.radiusLg);
    final innerRadius = BorderRadius.circular(PremiumTokens.radiusMd);

    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.045)
              : Colors.black.withValues(alpha: 0.035),
          borderRadius: radius,
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: isDark ? 0.10 : 0.16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.08),
              blurRadius: 28,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(
                alpha: opacity.clamp(0.16, 0.94),
              ),
              borderRadius: innerRadius,
              border: Border.all(
                color: Colors.white.withValues(alpha: isDark ? 0.08 : 0.40),
              ),
            ),
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}
