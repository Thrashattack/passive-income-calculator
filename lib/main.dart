import 'package:passive_income_calculator/logic/calcBigGoal.dart';
import 'package:passive_income_calculator/logic/getBigGoals.dart';
import 'package:passive_income_calculator/logic/saveBigGoal.dart';
import 'package:passive_income_calculator/pages/history.dart';
import 'package:passive_income_calculator/pages/preview.dart';
import 'package:flutter/material.dart';

void main() {
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
      home: MyHomePage(title: 'Faça uma Simulação'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue[900]!,
                Colors.blue[800]!,
                Colors.blue[400]!,
              ],
            ),
          ),
        ),
        title: Text(widget.title),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: !showSimulation
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
                      height: 36,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 36,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          onPressed: _submitSimulation,
                          child: Text('Simular'),
                        ),
                        SizedBox(
                          width: 36,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.redAccent)),
                          child: Text("Voltar"),
                          onPressed: () {
                            setState(() {
                              showSimulation = false;
                            });
                          },
                        )
                      ],
                    )
                  ]),
      ),
      bottomSheet: Container(
        color: Colors.blue,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ad Here',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
