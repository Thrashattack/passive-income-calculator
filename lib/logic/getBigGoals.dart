import 'package:localstorage/localstorage.dart';
import 'package:passive_income_calculator/logic/types/history.dart';

List<HistoryType> getBigGoals() {
  final LocalStorage storage = new LocalStorage('calculadora_renda_passiva');
  final List<HistoryType> history =
      storage.getItem('history') ?? List<HistoryType>.empty();
  return history;
}
