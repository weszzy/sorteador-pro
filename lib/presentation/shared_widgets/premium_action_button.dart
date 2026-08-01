import 'package:flutter/material.dart';

class PremiumActionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData icon;

  const PremiumActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  State<PremiumActionButton> createState() => _PremiumActionButtonState();
}

class _PremiumActionButtonState extends State<PremiumActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;

    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
      onTapUp: enabled
          ? (_) {
              setState(() => _pressed = false);
              widget.onPressed?.call();
            }
          : null,
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: enabled ? 1 : 0.46,
          duration: const Duration(milliseconds: 180),
          child: Container(
            height: 56,
            padding: const EdgeInsets.fromLTRB(22, 6, 8, 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.82),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.24),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  width: 42,
                  height: 42,
                  transform: Matrix4.translationValues(
                    _pressed ? 1 : 0,
                    _pressed ? -1 : 0,
                    0,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.onPrimary.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 20,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
