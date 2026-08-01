import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/services/haptic_service.dart';
import '../../../../core/services/toast_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_theme_types.dart';
import '../../../../core/theme/premium_tokens.dart';
import '../../../../presentation/shared_widgets/fluid_background.dart';
import '../../../../presentation/shared_widgets/glass_container.dart';
import '../../../../presentation/shared_widgets/premium_action_button.dart';
import '../../configuracoes/providers/theme_provider.dart';
import '../../historico/screens/historico_screen.dart';
import '../providers/sorteio_provider.dart';
import '../widgets/info_bottom_sheet.dart';
import '../widgets/share_card.dart';
import '../widgets/team_card.dart';

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
  void initState() {
    super.initState();
    _controllerComuns.addListener(_atualizarFormulario);
    _controllerVips.addListener(_atualizarFormulario);
  }

  @override
  void dispose() {
    _controllerComuns.removeListener(_atualizarFormulario);
    _controllerVips.removeListener(_atualizarFormulario);
    _controllerComuns.dispose();
    _controllerVips.dispose();
    super.dispose();
  }

  void _atualizarFormulario() => setState(() {});

  bool get _podeSortear =>
      _controllerComuns.text.trim().isNotEmpty ||
      (_isModoAvancado && _controllerVips.text.trim().isNotEmpty);

  int get _totalInformado =>
      _contarJogadores(_controllerComuns.text) +
      (_isModoAvancado ? _contarJogadores(_controllerVips.text) : 0);

  int get _timesPossiveis {
    if (_tamanhoTime < 1) return 0;
    return _totalInformado ~/ _tamanhoTime.round();
  }

  int get _sobrasPrevistas {
    if (_tamanhoTime < 1) return 0;
    return _totalInformado % _tamanhoTime.round();
  }

  int _contarJogadores(String texto) {
    return texto
        .split(RegExp(r'[\n,;]+'))
        .map((parte) => parte.trim())
        .where((nome) => nome.isNotEmpty)
        .toSet()
        .length;
  }

  Future<void> _compartilharTimes(
    List<List<String>> times,
    List<String> sobras,
  ) async {
    if (times.isEmpty) return;
    ToastService.showInfo(context, 'Gerando imagem...');

    try {
      final uint8List = await _screenshotController.captureFromWidget(
        ShareCard(times: times, sobras: sobras, data: DateTime.now()),
        delay: const Duration(milliseconds: 10),
        pixelRatio: 2.0,
      );
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/times_sorteados.png').create();
      await file.writeAsBytes(uint8List);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'image/png')],
          text: 'Confira os times!',
          title: 'Times sorteados',
        ),
      );
    } catch (e) {
      if (mounted) {
        ToastService.showError(context, 'Erro ao compartilhar: $e');
      }
    }
  }

  void _sortear() {
    HapticService.heavyImpact();
    FocusScope.of(context).unfocus();
    ref
        .read(sorteioProvider.notifier)
        .sortear(
          textoComuns: _controllerComuns.text,
          textoVips: _controllerVips.text,
          tamanhoTime: _tamanhoTime.round(),
          isModoAvancado: _isModoAvancado,
        );
  }

  @override
  Widget build(BuildContext context) {
    final estado = ref.watch(sorteioProvider);
    final currentThemeType = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;

    return Scaffold(
      body: FluidBackground(
        type: currentThemeType,
        child: SafeArea(
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: _TopBar(
                        currentThemeType: currentThemeType,
                        onThemeSelected: ref
                            .read(themeProvider.notifier)
                            .setTheme,
                        onHistoryPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HistoricoScreen(),
                            ),
                          );
                        },
                        onInfoPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const InfoBottomSheet(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: GlassContainer(
                        opacity: 0.78,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Eyebrow(
                              icon: Icons.sports_soccer,
                              label: _isModoAvancado
                                  ? 'Times equilibrados'
                                  : 'Sorteio rápido',
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Monte os times em segundos',
                              style: TextStyle(
                                fontSize: 28,
                                height: 1.05,
                                fontWeight: FontWeight.w800,
                                color: onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Cole os nomes, ajuste as opções e faça um sorteio justo.',
                              style: TextStyle(
                                height: 1.38,
                                color: onSurface.withValues(alpha: 0.64),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SegmentedButton<bool>(
                              segments: const [
                                ButtonSegment(
                                  value: false,
                                  icon: Icon(Icons.shuffle_rounded),
                                  label: Text('Simples'),
                                ),
                                ButtonSegment(
                                  value: true,
                                  icon: Icon(Icons.star_rounded),
                                  label: Text('Avançado'),
                                ),
                              ],
                              selected: {_isModoAvancado},
                              onSelectionChanged: (selection) {
                                setState(() {
                                  _isModoAvancado = selection.first;
                                });
                              },
                            ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: _controllerComuns,
                              maxLines: 5,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                labelText: 'Jogadores',
                                helperText:
                                    'Um nome por linha, vírgula ou ponto e vírgula.',
                                prefixIcon: Icon(Icons.people_outline),
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              child: _isModoAvancado
                                  ? Padding(
                                      key: const ValueKey('vips'),
                                      padding: const EdgeInsets.only(top: 12),
                                      child: TextField(
                                        controller: _controllerVips,
                                        maxLines: 3,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: const InputDecoration(
                                          labelText: 'Goleiros / craques',
                                          helperText:
                                              'Distribuídos primeiro entre os times.',
                                          prefixIcon: Icon(
                                            Icons.star_outline_rounded,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.groups_2_outlined,
                                  color: colorScheme.primary,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Jogadores por time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: onSurface,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${_tamanhoTime.round()}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
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
                              label: '${_tamanhoTime.round()}',
                              onChanged: (val) {
                                setState(() => _tamanhoTime = val);
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: _MetricTile(
                                    label: 'Jogadores',
                                    value: '$_totalInformado',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _MetricTile(
                                    label: 'Times',
                                    value: '$_timesPossiveis',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _MetricTile(
                                    label: 'Próximos',
                                    value: '$_sobrasPrevistas',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            PremiumActionButton(
                              onPressed: _podeSortear ? _sortear : null,
                              label: 'Sortear times',
                              icon: Icons.arrow_forward_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (estado.times.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 82,
                              height: 82,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.primary.withValues(
                                  alpha: 0.10,
                                ),
                                border: Border.all(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.18,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.groups_2_outlined,
                                size: 38,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Nenhum time sorteado',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: onSurface.withValues(alpha: 0.76),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'O resultado aparece aqui com as fichas de cada time.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: onSurface.withValues(alpha: 0.54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0) {
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 760),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                10,
                                16,
                                14,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Resultado',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 22,
                                      color: onSurface,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (estado.times.isNotEmpty)
                                    _RoundIconButton(
                                      tooltip: 'Compartilhar resultado',
                                      icon: Icons.ios_share_rounded,
                                      onPressed: () => _compartilharTimes(
                                        estado.times,
                                        estado.sobras,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      final timeIndex = index - 1;
                      if (timeIndex < estado.times.length) {
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 760),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: TeamCard(
                                index: timeIndex,
                                players: estado.times[timeIndex],
                              ),
                            ),
                          ),
                        );
                      }

                      if (estado.sobras.isNotEmpty) {
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 760),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 48),
                              child: GlassContainer(
                                opacity: 0.70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Próximos (de fora)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: estado.sobras
                                          .map(
                                            (p) => Chip(
                                              label: Text(p),
                                              backgroundColor: colorScheme
                                                  .surface
                                                  .withValues(alpha: 0.78),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return const SizedBox(height: 40);
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

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.currentThemeType,
    required this.onThemeSelected,
    required this.onHistoryPressed,
    required this.onInfoPressed,
  });

  final AppThemeType currentThemeType;
  final ValueChanged<AppThemeType> onThemeSelected;
  final VoidCallback onHistoryPressed;
  final VoidCallback onInfoPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: colorScheme.surface.withValues(alpha: 0.80),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.sports_soccer,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Sorteador Pro',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        _ThemeMenu(
          currentThemeType: currentThemeType,
          onSelected: onThemeSelected,
        ),
        const SizedBox(width: 8),
        _RoundIconButton(
          tooltip: 'Histórico',
          icon: Icons.history_rounded,
          onPressed: onHistoryPressed,
        ),
        const SizedBox(width: 8),
        _RoundIconButton(
          tooltip: 'Como funciona',
          icon: Icons.info_outline_rounded,
          onPressed: onInfoPressed,
        ),
      ],
    );
  }
}

class _ThemeMenu extends StatelessWidget {
  const _ThemeMenu({required this.currentThemeType, required this.onSelected});

  final AppThemeType currentThemeType;
  final ValueChanged<AppThemeType> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<AppThemeType>(
      tooltip: 'Mudar tema',
      initialValue: currentThemeType,
      onSelected: onSelected,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.80),
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.12),
          ),
        ),
        child: Icon(
          Icons.palette_outlined,
          size: 20,
          color: colorScheme.onSurface,
        ),
      ),
      itemBuilder: (context) => [
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
                    color: AppTheme.getTheme(theme).colorScheme.primary,
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.35),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(theme.label)),
                if (currentThemeType == theme)
                  Icon(Icons.check, size: 18, color: colorScheme.primary),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.80),
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.12),
            ),
          ),
          child: Icon(icon, size: 20, color: colorScheme.onSurface),
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 12, 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.primary),
          const SizedBox(width: 7),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(PremiumTokens.radiusSm),
        border: Border.all(color: onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 20,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: onSurface.withValues(alpha: 0.55),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
