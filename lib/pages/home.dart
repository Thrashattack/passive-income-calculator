import 'package:flutter/material.dart';
import 'package:passive_income_calculator/components/container.dart';
import 'package:passive_income_calculator/logic/calcBigGoal.dart';
import 'package:passive_income_calculator/logic/getBigGoals.dart';
import 'package:passive_income_calculator/logic/saveBigGoal.dart';
import 'package:passive_income_calculator/pages/history.dart';
import 'package:passive_income_calculator/pages/preview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showSimulation = false;
  final _controllerDesiredIncome = TextEditingController();
  final _controllerCurrentlyLiquidIncome = TextEditingController();
  final _controllerCurrentlySavesPercentual = TextEditingController();
  final _controllerCurrentlySaves = TextEditingController();
  final _controllerPassiveIncomeYield = TextEditingController();
  final _controllerApplicationYield = TextEditingController();
  final _controllerBigGoal = TextEditingController();

  _submitSimulation() {
    if (_controllerDesiredIncome.text.isNotEmpty &&
        _controllerCurrentlyLiquidIncome.text.isNotEmpty &&
        _controllerCurrentlySavesPercentual.text.isNotEmpty &&
        _controllerCurrentlySaves.text.isNotEmpty &&
        _controllerPassiveIncomeYield.text.isNotEmpty &&
        _controllerApplicationYield.text.isNotEmpty &&
        _controllerBigGoal.text.isNotEmpty) {
      List<Map<String, double>> years = calcBigGoal(
        double.parse(_controllerBigGoal.text),
        double.parse(_controllerPassiveIncomeYield.text),
        double.parse(_controllerCurrentlySaves.text),
      );

      saveBigGoal(years);
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Preview(years),
        ),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
            height: 80,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ad Here",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            )),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.blueAccent],
              ),
            ),
          ),
          title: Text("Calculadora de Renda Fixa"),
        ),
        body: defaultContainer(
            child: !showSimulation
                ? <Widget>[
                    Padding(
                      padding: EdgeInsets.all(80),
                      child: Text(
                        'Bem vindo ao simulador de renda fixa. Insira alguns dados sobre seu rendimento e veja em quanto tempo é possível atingir seu objetivo de renda fixa mensal.\n Clique no + para simular.',
                        style: TextStyle(fontSize: 16),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: 'goToHistory',
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    History(getBigGoals()),
                              )),
                          tooltip: 'Histórico',
                          child: Icon(Icons.history),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        FloatingActionButton(
                          heroTag: 'newSimulation',
                          onPressed: () =>
                              setState(() => showSimulation = true),
                          tooltip: 'Nova Simulação',
                          child: Icon(Icons.add),
                        )
                      ],
                    )
                  ]
                : <Widget>[
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
                                    _controllerCurrentlySaves
                                        .text = (double.parse(
                                                _controllerCurrentlyLiquidIncome
                                                    .text) *
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
                                  labelText:
                                      'Rendimento da Renda Passiva (em %)',
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    _controllerBigGoal.text = ((double.parse(
                                                    _controllerDesiredIncome
                                                        .text) *
                                                12) /
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
                              style: TextStyle(
                                  color: Colors.deepPurple, fontSize: 20),
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.redAccent)),
                          onPressed: () {
                            setState(() {
                              showSimulation = false;
                            });
                          },
                          child: Text('Voltar'),
                        ),
                        SizedBox(
                          width: 36,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          child: Text("Simular"),
                          onPressed: _submitSimulation,
                        ),
                        SizedBox(
                          width: 36,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue)),
                          child: Text("Limpar"),
                          onPressed: () => _clearForm(),
                        )
                      ],
                    )
                  ]));
  }
}
