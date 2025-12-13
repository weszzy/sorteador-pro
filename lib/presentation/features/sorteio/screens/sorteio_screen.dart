import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_theme_types.dart';
import '../../../../presentation/shared_widgets/glass_container.dart';
import '../../configuracoes/providers/theme_provider.dart';
import '../../historico/screens/historico_screen.dart';
import '../providers/sorteio_provider.dart';
import '../widgets/team_card.dart';
import '../widgets/share_card.dart';
import '../widgets/info_bottom_sheet.dart';
import '../../../../presentation/shared_widgets/fluid_background.dart';

class SorteioScreen extends ConsumerStatefulWidget {
  const SorteioScreen({super.key});

  @override
  ConsumerState<SorteioScreen> createState() => _SorteioScreenState();
}

class _SorteioScreenState extends ConsumerState<SorteioScreen> {
  final _controllerComuns = TextEditingController();
  final _controllerVips = TextEditingController();
  final _screenshotController = ScreenshotController();

  double _tamanhoTime = 5;
  bool _isModoAvancado = false;

  @override
  void dispose() {
    _controllerComuns.dispose();
    _controllerVips.dispose();
    super.dispose();
  }

  Future<void> _compartilharTimes(
    List<List<String>> times,
    List<String> sobras,
  ) async {
    if (times.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gerando imagem...'),
        duration: Duration(seconds: 1),
      ),
    );
    try {
      final uint8List = await _screenshotController.captureFromWidget(
        ShareCard(times: times, sobras: sobras, data: DateTime.now()),
        delay: const Duration(milliseconds: 10),
        pixelRatio: 2.0,
      );
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/times_sorteados.png').create();
      await file.writeAsBytes(uint8List);
      await Share.shareXFiles([XFile(file.path)], text: 'Confira os times! ⚽');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final estado = ref.watch(sorteioProvider);
    final currentThemeType = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Sorteador Pro',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),

        actions: [
          if (estado.times.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.share),
              tooltip: 'Compartilhar Resultado',
              onPressed: () => _compartilharTimes(estado.times, estado.sobras),
            ),

          PopupMenuButton<AppThemeType>(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Mudar Tema',
            initialValue: currentThemeType,
            onSelected: (AppThemeType newTheme) {
              ref.read(themeProvider.notifier).setTheme(newTheme);
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<AppThemeType>>[
                  ...AppThemeType.values.map((theme) {
                    return PopupMenuItem<AppThemeType>(
                      value: theme,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.getTheme(
                                theme,
                              ).colorScheme.primary,
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(theme.label),
                          if (currentThemeType == theme) ...[
                            const Spacer(),
                            Icon(
                              Icons.check,
                              size: 18,
                              color: colorScheme.primary,
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                ],
          ),

          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Mais Opções',
            onSelected: (String value) {
              if (value == 'historico') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoricoScreen()),
                );
              } else if (value == 'info') {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const InfoBottomSheet(),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'historico',
                child: Row(
                  children: [
                    Icon(Icons.history, size: 20),
                    SizedBox(width: 12),
                    Text('Histórico'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'info',
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20),
                    SizedBox(width: 12),
                    Text('Como funciona?'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(width: 8),
        ],
      ),
      body: FluidBackground(
        type: currentThemeType,
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchListTile(
                          title: Text(
                            'Sorteio Avançado',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          subtitle: const Text(
                            'Separar Goleiros/Craques',
                            style: TextStyle(fontSize: 12),
                          ),
                          value: _isModoAvancado,
                          onChanged: (val) =>
                              setState(() => _isModoAvancado = val),
                          activeColor: colorScheme.primary,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        Divider(color: colorScheme.outline.withOpacity(0.2)),
                        TextField(
                          controller: _controllerComuns,
                          maxLines: 3,
                          style: TextStyle(color: colorScheme.onSurface),
                          decoration: InputDecoration(
                            labelText: _isModoAvancado
                                ? 'Jogadores Comuns'
                                : 'Lista de Jogadores',
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.people_outline,
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ),
                        if (_isModoAvancado) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: colorScheme.primary.withOpacity(0.2),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: TextField(
                                controller: _controllerVips,
                                maxLines: 2,
                                style: TextStyle(color: colorScheme.onSurface),
                                decoration: InputDecoration(
                                  labelText: 'Goleiros / Craques',
                                  labelStyle: TextStyle(
                                    color: colorScheme.primary,
                                  ),
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.star,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.sports_soccer,
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                            const SizedBox(width: 10),
                            const Text('Jogadores por time:'),
                            const Spacer(),
                            Text(
                              '${_tamanhoTime.round()}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: _tamanhoTime,
                          min: 2,
                          max: 11,
                          divisions: 9,
                          onChanged: (val) =>
                              setState(() => _tamanhoTime = val),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              ref
                                  .read(sorteioProvider.notifier)
                                  .sortear(
                                    textoComuns: _controllerComuns.text,
                                    textoVips: _controllerVips.text,
                                    tamanhoTime: _tamanhoTime.round(),
                                    isModoAvancado: _isModoAvancado,
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'SORTEAR TIMES',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (estado.times.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_soccer_outlined,
                          size: 80,
                          color: colorScheme.onSurface.withOpacity(0.1),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aguardando jogadores...',
                          style: TextStyle(
                            fontSize: 18,
                            color: colorScheme.onSurface.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              "RESULTADO",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ),
                        );
                      }
                      final timeIndex = index - 1;
                      if (timeIndex < estado.times.length) {
                        return TeamCard(
                          index: timeIndex,
                          players: estado.times[timeIndex],
                          blur: 5.0,
                        );
                      } else {
                        if (estado.sobras.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 60),
                            child: GlassContainer(
                              opacity: 0.1,
                              child: Column(
                                children: [
                                  Text(
                                    'PRÓXIMOS (DE FORA)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    children: estado.sobras
                                        .map(
                                          (p) => Chip(
                                            label: Text(p),
                                            backgroundColor: colorScheme.surface
                                                .withOpacity(0.5),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox(height: 40);
                      }
                    },
                    childCount:
                        1 +
                        estado.times.length +
                        (estado.sobras.isNotEmpty ? 1 : 0),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
