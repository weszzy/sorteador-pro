import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../data/datasources/historico_datasource.dart';
import '../../../shared_widgets/glass_container.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = HistoricoDataSource();

    final brightness = Theme.of(context).brightness;
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = colorScheme.onSurface;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Histórico de Partidas',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              datasource.limparHistorico();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getBackgroundGradient(brightness),
        ),
        child: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: Hive.box(HistoricoDataSource.boxName).listenable(),
            builder: (context, box, _) {
              final historico = datasource.lerHistorico();

              if (historico.isEmpty) {
                return Center(
                  child: Text(
                    'Nenhum sorteio realizado ainda.',
                    style: TextStyle(color: textColor.withOpacity(0.7)),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: historico.length,
                itemBuilder: (context, index) {
                  final item = historico[index];
                  final dataRaw = DateTime.parse(item['data']);
                  final hour = dataRaw.hour.toString().padLeft(2, '0');
                  final minute = dataRaw.minute.toString().padLeft(2, '0');
                  final dataFormatada =
                      "${dataRaw.day}/${dataRaw.month} às $hour:$minute";
                  final List times = item['times'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GlassContainer(
                      opacity: 0.15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sorteio ${historico.length - index}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                dataFormatada,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          Divider(color: colorScheme.outline.withOpacity(0.3)),
                          ...times.map(
                            (time) => Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "⚽ ${(time as List).join(', ')}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor.withOpacity(0.9),
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
}
