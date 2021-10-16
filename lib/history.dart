import 'package:calculadora_renda_passiva/preview.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final List list;

  History(this.list);

  @override
  Widget build(BuildContext context) {
    _submitSimulation(index) {
      var item = list[index];
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Preview(
            rendaMensalDesejada:
                double.parse(item['rendaMensalDesejada'].toString()),
            rendaMensalLiquidaAtual:
                double.parse(item['rendaMensalLiquidaAtual'].toString()),
            economiaAtualPercentual:
                double.parse(item['economiaAtualPercentual'].toString()),
            economiaAtual: double.parse(item['economiaAtual'].toString()),
            rendimentoDaRendaPassiva:
                double.parse(item['rendimentoDaRendaPassiva'].toString()),
            rendimentoDasAplicacoes:
                double.parse(item['rendimentoDasAplicacoes'].toString()),
            grandeObjetivo: double.parse(item['grandeObjetivo'].toString()),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(list[index]['dataCriacao']!,
                        style: TextStyle(fontSize: 20)),
                    FloatingActionButton(
                      onPressed: () => _submitSimulation(index),
                      child: Icon(Icons.remove_red_eye),
                      tooltip: 'Ver Simulação',
                    ),
                  ]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => Navigator.pop(context),
        tooltip: 'Home',
        child: Icon(Icons.home),
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
