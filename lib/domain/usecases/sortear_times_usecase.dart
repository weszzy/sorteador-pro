import 'dart:math';

class SortearTimesUseCase {
  List<List<String>> call(List<String> jogadores, int tamanhoTime) {
    if (jogadores.isEmpty || tamanhoTime < 1) return [];
    final random = Random();
    final shuffled = List<String>.from(jogadores);

    for (int i = shuffled.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = shuffled[i];
      shuffled[i] = shuffled[j];
      shuffled[j] = temp;
    }

    List<List<String>> times = [];
    for (var i = 0; i < shuffled.length; i += tamanhoTime) {
      if (i + tamanhoTime <= shuffled.length) {
        times.add(shuffled.sublist(i, i + tamanhoTime));
      }
    }
    return times;
  }

  List<String> getSobras(List<String> jogadores, int tamanhoTime) {
    int numJogadoresNosTimes = (jogadores.length ~/ tamanhoTime) * tamanhoTime;
    return [];
  }
}
