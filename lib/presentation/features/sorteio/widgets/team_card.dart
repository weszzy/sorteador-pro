import 'package:flutter/material.dart';

import '../../../../core/theme/premium_tokens.dart';

class TeamCard extends StatelessWidget {
  final int index;
  final List<String> players;

  const TeamCard({super.key, required this.index, required this.players});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = colorScheme.onSurface;
    final teamColor =
        PremiumTokens.teamPalette[index % PremiumTokens.teamPalette.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PremiumTokens.radiusLg),
          color: isDark
              ? Colors.white.withValues(alpha: 0.045)
              : Colors.black.withValues(alpha: 0.035),
          border: Border.all(color: onSurface.withValues(alpha: 0.08)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PremiumTokens.radiusMd),
              color: colorScheme.surface.withValues(
                alpha: isDark ? 0.82 : 0.88,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.07),
                  blurRadius: 24,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(PremiumTokens.radiusMd),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 7,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            teamColor,
                            teamColor.withValues(alpha: 0.40),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${index + 1}'.padLeft(2, '0'),
                                  style: TextStyle(
                                    color: teamColor.withValues(alpha: 0.92),
                                    fontSize: 34,
                                    height: 0.95,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time ${index + 1}',
                                        style: TextStyle(
                                          color: onSurface,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${players.length} jogadores',
                                        style: TextStyle(
                                          color: onSurface.withValues(
                                            alpha: 0.55,
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: teamColor.withValues(alpha: 0.14),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: teamColor.withValues(alpha: 0.22),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.shield_outlined,
                                    color: teamColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: players.map((player) {
                                return _PlayerPill(
                                  name: player,
                                  accent: teamColor,
                                  onSurface: onSurface,
                                  isDark: isDark,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerPill extends StatelessWidget {
  const _PlayerPill({
    required this.name,
    required this.accent,
    required this.onSurface,
    required this.isDark,
  });

  final String name;
  final Color accent;
  final Color onSurface;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.055)
            : Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 11,
              backgroundColor: accent.withValues(alpha: 0.18),
              child: Text(
                name.characters.first.toUpperCase(),
                style: TextStyle(
                  color: accent,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 7),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 168),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: onSurface.withValues(alpha: 0.90),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
