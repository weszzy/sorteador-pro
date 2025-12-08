import 'package:flutter/material.dart';
import '../../../shared_widgets/glass_container.dart';

class TeamCard extends StatelessWidget {
  final int index;
  final List<String> players;
  final double blur;

  const TeamCard({
    super.key,
    required this.index,
    required this.players,
    this.blur = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    final teamColor = colors[index % colors.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassContainer(
        blur: blur,
        opacity: isDark ? 0.2 : 0.6,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: teamColor.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time ${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Icon(Icons.shield, color: teamColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  children: players.map((player) {
                    return Chip(
                      avatar: CircleAvatar(
                        backgroundColor: teamColor.withOpacity(0.8),
                        child: Text(
                          player.isNotEmpty ? player[0].toUpperCase() : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      label: Text(player, style: const TextStyle(fontSize: 14)),
                      backgroundColor: Theme.of(
                        context,
                      ).cardColor.withOpacity(0.5),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 0,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
