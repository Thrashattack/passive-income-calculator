import 'package:flutter/material.dart';
import 'package:passive_income_calculator/components/container.dart';
import 'package:passive_income_calculator/core/logic/calcYearsToBigGoal.dart';
import 'package:passive_income_calculator/core/data/saveBigGoal.dart';
import 'package:passive_income_calculator/pages/preview.dart';

class Simulation extends StatefulWidget {
  @override
  _SimulationState createState() => _SimulationState();
}

class _SimulationState extends State<Simulation> {
  final _controllerDesiredIncome = TextEditingController();
  final _controllerCurrentlyLiquidIncome = TextEditingController();
  final _controllerCurrentlySavesPercentual = TextEditingController();
  final _controllerCurrentlySaves = TextEditingController();
  final _controllerPassiveIncomeYield = TextEditingController();
  final _controllerApplicationYield = TextEditingController();
  final _controllerBigGoal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(title: "Simulador de Renda Fixa", child: [
      Column(
        children: [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Insira a Renda Mensal Desejada';
                  }
                  return null;
                },
                controller: _controllerDesiredIncome,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Renda Mensal Desejada',
                ),
              )),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Insira a Renda Mensal Liquida Atual';
                  }
                  return null;
                },
                controller: _controllerCurrentlyLiquidIncome,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Renda Mensal Liquida Atual',
                ),
              )),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Insira a Economia Atual (em %)';
                    }
                    return null;
                  },
                  controller: _controllerCurrentlySavesPercentual,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Economia Atual (em %)',
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _controllerCurrentlySaves.text =
                          (double.parse(_controllerCurrentlyLiquidIncome.text) *
                                  (double.parse(value) / 100))
                              .toStringAsFixed(2);
                    }
                  })),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(color: Colors.green),
                enabled: false,
                controller: _controllerCurrentlySaves,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Economia Atual',
                ),
              )),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Insira o Rendimento da Renda Passiva';
                    }
                    return null;
                  },
                  controller: _controllerPassiveIncomeYield,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rendimento da Renda Passiva (em %)',
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _controllerBigGoal.text =
                          ((double.parse(_controllerDesiredIncome.text) * 12) /
                                  (double.parse(value) / 100))
                              .toStringAsFixed(2);
                    }
                  })),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Insira o Rendimento das Aplicações';
                  }
                  return null;
                },
                controller: _controllerApplicationYield,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Rendimento das Aplicações (em %)',
                ),
              )),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                enabled: false,
                controller: _controllerBigGoal,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Grande Objetivo',
                ),
              )),
        ],
      ),
      SizedBox(
        height: 24,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent)),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Text('Voltar'),
          ),
          SizedBox(
            width: 36,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            child: Text("Simular"),
            onPressed: _submitSimulation,
          ),
          SizedBox(
            width: 36,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            child: Text("Limpar"),
            onPressed: () => _clearForm(),
          )
        ],
      )
    ]);
  }

  _clearForm() {
    _controllerDesiredIncome.clear();
    _controllerCurrentlyLiquidIncome.clear();
    _controllerCurrentlySavesPercentual.clear();
    _controllerCurrentlySaves.clear();
    _controllerPassiveIncomeYield.clear();
    _controllerApplicationYield.clear();
    _controllerBigGoal.clear();
  }

  _submitSimulation() {
    if (_controllerDesiredIncome.text.isNotEmpty &&
        _controllerCurrentlyLiquidIncome.text.isNotEmpty &&
        _controllerCurrentlySavesPercentual.text.isNotEmpty &&
        _controllerCurrentlySaves.text.isNotEmpty &&
        _controllerPassiveIncomeYield.text.isNotEmpty &&
        _controllerApplicationYield.text.isNotEmpty &&
        _controllerBigGoal.text.isNotEmpty) {
      List<Map<String, double>> yearsToBigGoal = calcYearsToBigGoal(
        double.parse(_controllerBigGoal.text.replaceAll(',', '.')),
        double.parse(_controllerPassiveIncomeYield.text.replaceAll(',', '.')),
        double.parse(_controllerCurrentlySaves.text.replaceAll(',', '.')),
      );

      saveBigGoal(yearsToBigGoal);
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => PreviewPage(
            yearsToBigGoal: yearsToBigGoal,
            context: context,
          ),
        ),
      );
    }
  }
}
