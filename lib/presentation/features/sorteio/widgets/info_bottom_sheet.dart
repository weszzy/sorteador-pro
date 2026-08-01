import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoBottomSheet extends StatelessWidget {
  const InfoBottomSheet({super.key});

  static final Uri _instagramUrl = Uri.parse(
    'https://www.instagram.com/weszzy/',
  );

  Future<void> _openInstagram(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final launched = await launchUrl(
      _instagramUrl,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o Instagram.')),
      );
    }
  }

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
            const SizedBox(height: 16),
            Divider(color: colorScheme.outline.withValues(alpha: 0.12)),
            const SizedBox(height: 16),
            Text('Créditos', style: titleStyle),
            const SizedBox(height: 10),
            _CreatorCredit(
              colorScheme: colorScheme,
              onTap: () => _openInstagram(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreatorCredit extends StatelessWidget {
  const _CreatorCredit({required this.colorScheme, required this.onTap});

  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Abrir Instagram de Daniel Dutra, @weszzy',
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.14),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.12),
                ),
                child: Center(
                  child: _InstagramGlyph(color: colorScheme.primary),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daniel Dutra',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '@weszzy',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.open_in_new_rounded,
                size: 18,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstagramGlyph extends StatelessWidget {
  const _InstagramGlyph({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(22),
      painter: _InstagramPainter(color),
    );
  }
}

class _InstagramPainter extends CustomPainter {
  const _InstagramPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final rect = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.deflate(1), const Radius.circular(6)),
      stroke,
    );
    canvas.drawCircle(size.center(Offset.zero), size.width * 0.22, stroke);

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.28),
      size.width * 0.06,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _InstagramPainter oldDelegate) {
    return oldDelegate.color != color;
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
