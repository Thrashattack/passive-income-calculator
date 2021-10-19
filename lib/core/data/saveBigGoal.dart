import 'package:localstorage/localstorage.dart';
import 'package:passive_income_calculator/core/types/history.dart';

void saveBigGoal(List<Map<String, double>> yearsToBigGoal) {
  final LocalStorage storage = new LocalStorage('calculadora_renda_passiva');
  final List<HistoryType> history = storage.getItem('history') ?? [];

  history.add(new HistoryType(
      dateCreated: DateTime.now().toLocal().toString(),
      yearsToBigGoal: yearsToBigGoal));

  storage.setItem('history', history);
}
