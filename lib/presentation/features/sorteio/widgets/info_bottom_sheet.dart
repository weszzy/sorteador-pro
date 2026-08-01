import 'package:flutter/material.dart';

class InfoBottomSheet extends StatelessWidget {
  const InfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 16,
      color: colorScheme.onSurface,
    );
    final textStyle = TextStyle(
      height: 1.42,
      fontSize: 13,
      color: colorScheme.onSurface.withValues(alpha: 0.74),
    );

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Como funciona o sorteio?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 18),
            _InfoSection(
              icon: Icons.shuffle_rounded,
              title: 'Modo normal',
              content:
                  'Os nomes são embaralhados com Fisher-Yates e distribuídos em times completos. Quem sobra aparece separado para a próxima rodada.',
              colorScheme: colorScheme,
              titleStyle: titleStyle,
              textStyle: textStyle,
            ),
            const SizedBox(height: 16),
            Divider(color: colorScheme.outline.withValues(alpha: 0.12)),
            const SizedBox(height: 16),
            _InfoSection(
              icon: Icons.star_rounded,
              title: 'Modo avançado',
              content:
                  'Goleiros e craques são distribuídos primeiro. Depois, os demais jogadores preenchem as vagas restantes.',
              colorScheme: colorScheme,
              titleStyle: titleStyle,
              textStyle: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.icon,
    required this.title,
    required this.content,
    required this.colorScheme,
    required this.titleStyle,
    required this.textStyle,
  });

  final IconData icon;
  final String title;
  final String content;
  final ColorScheme colorScheme;
  final TextStyle titleStyle;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: colorScheme.primary, size: 21),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle),
              const SizedBox(height: 4),
              Text(content, style: textStyle),
            ],
          ),
        ),
      ],
    );
  }
}
