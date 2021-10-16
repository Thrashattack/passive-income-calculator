import 'package:localstorage/localstorage.dart';

List getBigGoals() {
  final LocalStorage storage = new LocalStorage('calculadora_renda_passiva');
  List history = storage.getItem('history') ?? [];
  return history;
}
