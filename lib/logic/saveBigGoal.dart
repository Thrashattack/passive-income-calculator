import 'package:localstorage/localstorage.dart';

void saveBigGoal(List<Map<String, double>> years) {
  final LocalStorage storage = new LocalStorage('calculadora_renda_passiva');
  final List history = storage.getItem('history') ?? [];

  history.add(
      {'dateCreated': DateTime.now().toLocal().toString(), 'years': years});

  storage.setItem('history', history);
}
