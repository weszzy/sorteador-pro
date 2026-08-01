import 'package:flutter/material.dart';

import '../../../../core/theme/premium_tokens.dart';

class ShareCard extends StatelessWidget {
  final List<List<String>> times;
  final List<String> sobras;
  final DateTime data;

  const ShareCard({
    super.key,
    required this.times,
    required this.sobras,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final hour = data.hour.toString().padLeft(2, '0');
    final minute = data.minute.toString().padLeft(2, '0');
    final day = data.day.toString().padLeft(2, '0');
    final month = data.month.toString().padLeft(2, '0');
    final year = data.year.toString();

    return Material(
      color: PremiumTokens.ink,
      child: Container(
        width: 680,
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF151B24), PremiumTokens.ink],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: PremiumTokens.gold.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PremiumTokens.gold.withValues(alpha: 0.20),
                    ),
                  ),
                  child: const Icon(
                    Icons.sports_soccer,
                    color: PremiumTokens.gold,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SORTEIO OFICIAL',
                        style: TextStyle(
                          color: PremiumTokens.gold,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.6,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Sorteador Pro',
                        style: TextStyle(
                          color: PremiumTokens.cream,
                          fontSize: 30,
                          height: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _MetaRow(
                      icon: Icons.calendar_today,
                      text: '$day/$month/$year',
                    ),
                    const SizedBox(height: 5),
                    _MetaRow(icon: Icons.access_time, text: '$hour:$minute'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...List.generate((times.length / 2).ceil(), (rowIndex) {
              final firstIndex = rowIndex * 2;
              final secondIndex = firstIndex + 1;
              final hasSecond = secondIndex < times.length;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ShareTeamCard(
                        index: firstIndex,
                        players: times[firstIndex],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: hasSecond
                          ? _ShareTeamCard(
                              index: secondIndex,
                              players: times[secondIndex],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              );
            }),
            if (sobras.isNotEmpty) ...[
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: PremiumTokens.gold.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(PremiumTokens.radiusSm),
                  border: Border.all(
                    color: PremiumTokens.gold.withValues(alpha: 0.18),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'PRÓXIMOS (DE FORA)',
                      style: TextStyle(
                        color: PremiumTokens.gold,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 1.6,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      sobras.join('  •  '),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: PremiumTokens.cream.withValues(alpha: 0.82),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              'Gerado via Sorteador Pro',
              style: TextStyle(
                color: PremiumTokens.cream.withValues(alpha: 0.34),
                fontSize: 10,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: PremiumTokens.cream.withValues(alpha: 0.58),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: PremiumTokens.cream.withValues(alpha: 0.78),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ShareTeamCard extends StatelessWidget {
  const _ShareTeamCard({required this.index, required this.players});

  final int index;
  final List<String> players;

  @override
  Widget build(BuildContext context) {
    final accent =
        PremiumTokens.teamPalette[index % PremiumTokens.teamPalette.length];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(PremiumTokens.radiusMd),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PremiumTokens.radiusMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 6,
              height: 168,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [accent, accent.withValues(alpha: 0.34)],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${index + 1}'.padLeft(2, '0'),
                          style: TextStyle(
                            color: accent,
                            fontSize: 30,
                            height: 0.95,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Time ${index + 1}',
                            style: const TextStyle(
                              color: PremiumTokens.cream,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...players.map(
                      (jogador) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: Row(
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: accent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                jogador,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: PremiumTokens.cream.withValues(
                                    alpha: 0.86,
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
