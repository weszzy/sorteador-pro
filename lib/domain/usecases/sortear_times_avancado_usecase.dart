import 'dart:math';

class SortearTimesAvancadoUseCase {
  List<List<String>> call({
    required List<String> comuns,
    required List<String> vips,
    required int tamanhoTime,
  }) {
    final totalJogadores = comuns.length + vips.length;
    if (totalJogadores < tamanhoTime || tamanhoTime < 1) return [];
    final numTimes = totalJogadores ~/ tamanhoTime;
    if (numTimes == 0) return [];

    List<List<String>> times = List.generate(numTimes, (_) => []);
    final random = Random();
    final vipsEmbaralhados = List<String>.from(vips)..shuffle(random);
    final comunsEmbaralhados = List<String>.from(comuns)..shuffle(random);

    int timeIndex = 0;
    for (var vip in vipsEmbaralhados) {
      if (times[timeIndex].length < tamanhoTime) {
        times[timeIndex].add(vip);
      }
      timeIndex = (timeIndex + 1) % numTimes;
    }
    for (var comum in comunsEmbaralhados) {
      int tentativas = 0;
      while (times[timeIndex].length >= tamanhoTime && tentativas < numTimes) {
        timeIndex = (timeIndex + 1) % numTimes;
        tentativas++;
      }

      if (times[timeIndex].length < tamanhoTime) {
        times[timeIndex].add(comum);
        timeIndex = (timeIndex + 1) % numTimes;
      }
    }

    return times;
  }
}
