import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../data/datasources/historico_datasource.dart';
import '../../../shared_widgets/fluid_background.dart';
import '../../../shared_widgets/glass_container.dart';
import '../../configuracoes/providers/theme_provider.dart';

class HistoricoScreen extends ConsumerWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datasource = HistoricoDataSource();
    final currentThemeType = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico', style: TextStyle(color: textColor)),
        backgroundColor: colorScheme.surface.withValues(alpha: 0.82),
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Limpar histórico',
            onPressed: () => _confirmarLimpeza(context, datasource),
          ),
        ],
      ),
      body: FluidBackground(
        type: currentThemeType,
        child: SafeArea(
          top: false,
          child: ValueListenableBuilder(
            valueListenable: Hive.box(HistoricoDataSource.boxName).listenable(),
            builder: (context, box, _) {
              final historico = datasource.lerHistorico();
              if (historico.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_toggle_off,
                          size: 68,
                          color: textColor.withValues(alpha: 0.24),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Nenhum sorteio salvo',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: textColor.withValues(alpha: 0.72),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Os sorteios aparecem aqui automaticamente.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor.withValues(alpha: 0.56),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: historico.length,
                itemBuilder: (context, index) {
                  final item = historico[index];
                  final dataRaw = DateTime.parse(item['data'] as String);
                  final times = (item['times'] as List).cast<List>();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GlassContainer(
                      opacity: 0.70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Sorteio ${historico.length - index}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              Text(
                                _formatarData(dataRaw),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textColor.withValues(alpha: 0.64),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: colorScheme.outline.withValues(alpha: 0.18),
                          ),
                          ...times.indexed.map(
                            (entry) => Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                'Time ${entry.$1 + 1}: ${entry.$2.join(', ')}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor.withValues(alpha: 0.88),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  static String _formatarData(DateTime data) {
    final day = data.day.toString().padLeft(2, '0');
    final month = data.month.toString().padLeft(2, '0');
    final hour = data.hour.toString().padLeft(2, '0');
    final minute = data.minute.toString().padLeft(2, '0');
    return '$day/$month às $hour:$minute';
  }

  Future<void> _confirmarLimpeza(
    BuildContext context,
    HistoricoDataSource datasource,
  ) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar histórico?'),
        content: const Text('Esta ação remove todos os sorteios salvos.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );

    if (confirmou == true) {
      await datasource.limparHistorico();
    }
  }
}
