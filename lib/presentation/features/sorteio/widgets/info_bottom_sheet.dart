import 'package:flutter/material.dart';

class InfoBottomSheet extends StatelessWidget {
  const InfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(color: colorScheme.onSurface);
    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: colorScheme.primary,
    );

    return Container(
      padding: const EdgeInsets.all(24),
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
                color: colorScheme.onSurface.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Text(
            'Como funciona o Sorteio?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 20),

          _buildInfoSection(
            icon: Icons.shuffle,
            title: 'Sorteio Padrão (Aleatório)',
            content:
                'Utilizamos o algoritmo "Fisher-Yates Shuffle", o padrão ouro da computação para aleatoriedade. \n\n'
                'Imagine que todos os nomes são colocados em um saco escuro e retirados um a um. '
                'A probabilidade de qualquer jogador cair em qualquer time é matematicamente igual.',
            colorScheme: colorScheme,
            titleStyle: titleStyle,
            textStyle: textStyle,
          ),

          const SizedBox(height: 16),
          Divider(color: colorScheme.outline.withOpacity(0.1)),
          const SizedBox(height: 16),

          _buildInfoSection(
            icon: Icons.star,
            title: 'Modo Avançado (Cabeças de Chave)',
            content:
                'Ideal para equilibrar times. Funciona como os potes da Copa do Mundo.\n\n'
                '1. Primeiro, distribuímos os "Craques/Goleiros" um em cada time.\n'
                '2. Depois, preenchemos as vagas restantes com os jogadores comuns.\n\n'
                'Isso garante que nenhum time fique sem goleiro ou que todos os craques caiam no mesmo lado.',
            colorScheme: colorScheme,
            titleStyle: titleStyle,
            textStyle: textStyle,
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
    required ColorScheme colorScheme,
    required TextStyle titleStyle,
    required TextStyle textStyle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: colorScheme.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle),
              const SizedBox(height: 4),
              Text(
                content,
                style: textStyle.copyWith(
                  height: 1.4,
                  fontSize: 13,
                  color: textStyle.color?.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
