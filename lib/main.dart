import 'package:calculadora_renda_passiva/history.dart';
import 'package:calculadora_renda_passiva/preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraRendaPassiva());
}

class CalculadoraRendaPassiva extends StatelessWidget {
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
  var showSimulation = false;
  final _controllerRendaMensalDesejada = TextEditingController();
  final _controllerRendaMensalLiquidaAtual = TextEditingController();
  final _controllerEconomiaAtualPercentual = TextEditingController();
  final _controllerEconomiaAtual = TextEditingController();
  final _controllerRendimentoDaRendaPassiva = TextEditingController();
  final _controllerRendimentoDasAplicacoes = TextEditingController();
  final _controllerGrandeObjetivo = TextEditingController();

  _submitSimulation() {
    if (_controllerRendaMensalDesejada.text.isNotEmpty &&
        _controllerRendaMensalLiquidaAtual.text.isNotEmpty &&
        _controllerEconomiaAtualPercentual.text.isNotEmpty &&
        _controllerEconomiaAtual.text.isNotEmpty &&
        _controllerRendimentoDaRendaPassiva.text.isNotEmpty &&
        _controllerRendimentoDasAplicacoes.text.isNotEmpty &&
        _controllerGrandeObjetivo.text.isNotEmpty) {
      setState(() {
        showSimulation = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Preview(
            rendaMensalDesejada:
                double.parse(_controllerRendaMensalDesejada.text),
            rendaMensalLiquidaAtual:
                double.parse(_controllerRendaMensalLiquidaAtual.text),
            economiaAtualPercentual:
                double.parse(_controllerEconomiaAtualPercentual.text),
            economiaAtual: double.parse(_controllerEconomiaAtual.text),
            rendimentoDaRendaPassiva:
                double.parse(_controllerRendimentoDaRendaPassiva.text),
            rendimentoDasAplicacoes:
                double.parse(_controllerRendimentoDasAplicacoes.text),
            grandeObjetivo: double.parse(_controllerGrandeObjetivo.text),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: !showSimulation
                ? <Widget>[
                    Text(
                      'Toque no Botão + para simular.',
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    FloatingActionButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => History(),
                          )),
                      tooltip: 'Histórico',
                      child: Icon(Icons.history),
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
                              controller: _controllerRendaMensalDesejada,
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
                              controller: _controllerRendaMensalLiquidaAtual,
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
                                controller: _controllerEconomiaAtualPercentual,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Economia Atual (em %)',
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    _controllerEconomiaAtual
                                        .text = (double.parse(
                                                _controllerRendaMensalLiquidaAtual
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
                              controller: _controllerEconomiaAtual,
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
                                controller: _controllerRendimentoDaRendaPassiva,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Rendimento da Renda Passiva',
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    _controllerGrandeObjetivo
                                        .text = ((double.parse(
                                                    _controllerRendaMensalDesejada
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
                              controller: _controllerRendimentoDasAplicacoes,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Rendimento das Aplicações',
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.deepPurple, fontSize: 20),
                              enabled: false,
                              controller: _controllerGrandeObjetivo,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => showSimulation = true),
        tooltip: 'Nova Simulação',
        child: Icon(Icons.add),
      ),
    );
  }
}
