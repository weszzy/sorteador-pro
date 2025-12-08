import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../domain/usecases/sortear_times_usecase.dart';
import '../../../../../domain/usecases/sortear_times_avancado_usecase.dart';
import '../../../../../data/datasources/historico_datasource.dart';

class SorteioState {
  final List<List<String>> times;
  final List<String> sobras;

  SorteioState({this.times = const [], this.sobras = const []});
}

class SorteioNotifier extends StateNotifier<SorteioState> {
  final SortearTimesUseCase _useCaseSimples;
  final SortearTimesAvancadoUseCase _useCaseAvancado;
  final HistoricoDataSource _historicoDataSource;

  SorteioNotifier(
    this._useCaseSimples,
    this._useCaseAvancado,
    this._historicoDataSource,
  ) : super(SorteioState());

  void sortear({
    required String textoComuns,
    String? textoVips,
    required int tamanhoTime,
    bool isModoAvancado = false,
  }) {
    final listaComuns = textoComuns
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    List<List<String>> timesSorteados = [];
    final listaTotalParaCalculoSobras = [...listaComuns];

    if (isModoAvancado && textoVips != null && textoVips.isNotEmpty) {
      final listaVips = textoVips
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      listaTotalParaCalculoSobras.addAll(listaVips);
      timesSorteados = _useCaseAvancado(
        comuns: listaComuns,
        vips: listaVips,
        tamanhoTime: tamanhoTime,
      );
    } else {
      timesSorteados = _useCaseSimples(listaComuns, tamanhoTime);
    }

    final todosNosTimes = timesSorteados.expand((time) => time).toSet();
    final sobras = listaTotalParaCalculoSobras
        .where((jogador) => !todosNosTimes.contains(jogador))
        .toList();

    state = SorteioState(times: timesSorteados, sobras: sobras);
    if (timesSorteados.isNotEmpty) {
      _historicoDataSource.salvarSorteio(timesSorteados);
    }
  }
}

final sortearUseCaseProvider = Provider((ref) => SortearTimesUseCase());
final sortearAvancadoUseCaseProvider = Provider(
  (ref) => SortearTimesAvancadoUseCase(),
);
final historicoDataSourceProvider = Provider((ref) => HistoricoDataSource());
final sorteioProvider = StateNotifierProvider<SorteioNotifier, SorteioState>((
  ref,
) {
  return SorteioNotifier(
    ref.watch(sortearUseCaseProvider),
    ref.watch(sortearAvancadoUseCaseProvider),
    ref.watch(historicoDataSourceProvider),
  );
});
