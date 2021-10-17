import 'package:localstorage/localstorage.dart';
import 'package:passive_income_calculator/logic/types/history.dart';

void saveBigGoal(List<Map<String, double>> years) {
  final LocalStorage storage = new LocalStorage('calculadora_renda_passiva');
  final List<HistoryType> history = storage.getItem('history') ?? [];

  history.add(new HistoryType(
      dateCreated: DateTime.now().toLocal().toString(), years: years));

  storage.setItem('history', history);
}
