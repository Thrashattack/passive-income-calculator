import 'package:flutter/material.dart';
import 'package:passive_income_calculator/components/container.dart';
import 'package:passive_income_calculator/components/simulation.dart'
    as SimulationComponent;
import 'package:passive_income_calculator/core/data/getBigGoals.dart';
import 'package:passive_income_calculator/pages/history.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool showSimulation = false;

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(title: "Calculadora de Renda Fixa", child: [
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
                      HistoryPage(history: getBigGoals(), context: context),
                )),
            tooltip: 'Histórico',
            child: Icon(Icons.history),
          ),
          SizedBox(
            width: 80,
          ),
          FloatingActionButton(
            heroTag: 'newSimulation',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        SimulationComponent.Simulation(),
                  ));
            },
            tooltip: 'Nova Simulação',
            child: Icon(Icons.add),
          )
        ],
      )
    ]);
  }
}
