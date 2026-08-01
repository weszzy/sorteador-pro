import 'package:flutter_test/flutter_test.dart';
import 'package:sorteador_pro/domain/usecases/sortear_times_avancado_usecase.dart';
import 'package:sorteador_pro/domain/usecases/sortear_times_usecase.dart';

void main() {
  group('SortearTimesUseCase', () {
    test('cria apenas times completos', () {
      final useCase = SortearTimesUseCase();
      final times = useCase(['Ana', 'Bia', 'Caio', 'Davi', 'Eva'], 2);

      expect(times, hasLength(2));
      expect(times.every((time) => time.length == 2), isTrue);
      expect(times.expand((time) => time).toSet(), hasLength(4));
    });

    test('retorna vazio quando nao ha jogadores suficientes', () {
      final useCase = SortearTimesUseCase();

      expect(useCase(['Ana'], 2), isEmpty);
      expect(useCase([], 5), isEmpty);
    });
  });

  group('SortearTimesAvancadoUseCase', () {
    test('distribui vips antes dos jogadores comuns', () {
      final useCase = SortearTimesAvancadoUseCase();
      final times = useCase(
        comuns: ['Ana', 'Bia', 'Caio', 'Davi'],
        vips: ['Goleiro 1', 'Goleiro 2'],
        tamanhoTime: 3,
      );

      expect(times, hasLength(2));
      expect(times.every((time) => time.length == 3), isTrue);
      expect(
        times.every((time) => time.any((p) => p.startsWith('Goleiro'))),
        isTrue,
      );
    });

    test('retorna vazio quando nao ha jogadores suficientes', () {
      final useCase = SortearTimesAvancadoUseCase();

      expect(useCase(comuns: ['Ana'], vips: [], tamanhoTime: 2), isEmpty);
    });
  });
}
