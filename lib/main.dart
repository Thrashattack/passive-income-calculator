import 'package:flutter/material.dart';

import 'package:passive_income_calculator/pages/home.dart';
import 'package:passive_income_calculator/providers/AdManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AdManager.initialize();
  runApp(PassiveIncomeCalculator());
}

class PassiveIncomeCalculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calculadora de Renda Passiva',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}
