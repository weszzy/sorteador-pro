import 'package:hive_flutter/hive_flutter.dart';

class HistoricoDataSource {
  static const String boxName = 'historico';

  Future<void> salvarSorteio(List<List<String>> times) async {
    final box = Hive.box(boxName);
    final sorteio = {'data': DateTime.now().toIso8601String(), 'times': times};
    await box.add(sorteio);
  }

  List<Map<dynamic, dynamic>> lerHistorico() {
    final box = Hive.box(boxName);
    return box.values.toList().cast<Map<dynamic, dynamic>>().reversed.toList();
  }

  Future<void> limparHistorico() async {
    final box = Hive.box(boxName);
    await box.clear();
  }
}
