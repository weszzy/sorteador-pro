import 'package:flutter/material.dart';

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

    const textColor = Colors.white;
    const cardColor = Color(0xFF2A2D3E);
    const bgColor = Color(0xFF15171E);
    const accentColor = Color(0xFFD4AF37);

    return Container(
      width: 600,
      padding: const EdgeInsets.all(24),
      color: bgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SORTEIO OFICIAL',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sorteador Pro',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: textColor.withOpacity(0.6),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$day/$month/$year',
                        style: TextStyle(
                          color: textColor.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: textColor.withOpacity(0.6),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$hour:$minute',
                        style: TextStyle(
                          color: textColor.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 20),

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
                    child: _buildTeamCard(
                      context,
                      index: firstIndex,
                      players: times[firstIndex],
                      color: cardColor,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),
                  ),

                  const SizedBox(width: 16),
                  Expanded(
                    child: hasSecond
                        ? _buildTeamCard(
                            context,
                            index: secondIndex,
                            players: times[secondIndex],
                            color: cardColor,
                            textColor: textColor,
                            accentColor: accentColor,
                          )
                        : Container(),
                  ),
                ],
              ),
            );
          }),

          if (sobras.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  const Text(
                    'PRÓXIMOS (DE FORA)',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sobras.join('  •  '),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFFCC80),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sports_soccer,
                size: 12,
                color: textColor.withOpacity(0.3),
              ),
              const SizedBox(width: 6),
              Text(
                'Gerado via App Sorteador Pro®',
                style: TextStyle(
                  color: textColor.withOpacity(0.3),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCard(
    BuildContext context, {
    required int index,
    required List<String> players,
    required Color color,
    required Color textColor,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield, size: 18, color: accentColor),
              const SizedBox(width: 8),
              Text(
                'TIME ${index + 1}',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...players.map(
            (jogador) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Text(
                    "• ",
                    style: TextStyle(color: accentColor.withOpacity(0.5)),
                  ),
                  Expanded(
                    child: Text(
                      jogador,
                      style: TextStyle(
                        color: textColor.withOpacity(0.9),
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
