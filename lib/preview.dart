import 'package:flutter/material.dart';

class Preview extends StatelessWidget {
  final double rendaMensalDesejada;

  final double rendaMensalLiquidaAtual;

  final double economiaAtualPercentual;

  final double economiaAtual;

  final double rendimentoDaRendaPassiva;

  final double rendimentoDasAplicacoes;

  final double grandeObjetivo;

  final anos = [];

  double aporteAnual = 0.0;
  double rendimentoAnual = 0.0;
  double valorFinal = 0.0;
  double rendaPassivaAtualAno = 0.0;
  double rendaPassivaAtualMes = 0.0;
  int ano = 1;

  Preview(
      {required this.rendaMensalDesejada,
      required this.rendaMensalLiquidaAtual,
      required this.economiaAtualPercentual,
      required this.economiaAtual,
      required this.rendimentoDaRendaPassiva,
      required this.rendimentoDasAplicacoes,
      required this.grandeObjetivo});
  @override
  Widget build(BuildContext context) {
    while (this.aporteAnual < this.grandeObjetivo) {
      this.aporteAnual = this.valorFinal + (this.economiaAtual * 12);
      this.rendimentoAnual = this.rendimentoDaRendaPassiva;
      this.valorFinal =
          this.aporteAnual + (this.aporteAnual * (this.rendimentoAnual / 100));
      this.rendaPassivaAtualAno =
          this.valorFinal * (this.rendimentoDaRendaPassiva / 100);
      this.rendaPassivaAtualMes = this.rendaPassivaAtualAno / 12;

      this.anos.add({
        "aporteAnual": aporteAnual,
        "rendimentoAnual": rendimentoAnual,
        "valorFinal": valorFinal,
        "rendaPassivaAtualAno": rendaPassivaAtualAno,
        "rendaPassivaAtualMes": rendaPassivaAtualMes
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Previsão"),
      ),
      body: Container(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Table(
              border: TableBorder.all(width: 1.0, color: Colors.black),
              children: [
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 2.0,
                                color: Colors.green,
                                style: BorderStyle.solid),
                            left: BorderSide(
                                width: 2.0,
                                color: Colors.green,
                                style: BorderStyle.solid),
                            top: BorderSide(
                                width: 2.0,
                                color: Colors.green,
                                style: BorderStyle.solid),
                            bottom: BorderSide(
                                width: 2.0,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text("Ano", style: TextStyle(fontSize: 16)),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text("Aporte Anual",
                            style: TextStyle(fontSize: 16)),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text("Rendimento Anual",
                            style: TextStyle(fontSize: 16)),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child:
                            Text("Valor Final", style: TextStyle(fontSize: 16)),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text("Renda Passiva Anual",
                            style: TextStyle(fontSize: 16)),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text("Renda Passiva Mensal",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ]),
                ...this.anos.map((ano) {
                  return TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "${this.anos.indexOf(ano) + 1}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "R\$ ${ano['aporteAnual'].toStringAsFixed(2)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "${ano['rendimentoAnual'].toStringAsFixed(2)} %",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "R\$ ${ano['valorFinal'].toStringAsFixed(2)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "R\$ ${ano['rendaPassivaAtualAno'].toStringAsFixed(2)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "R\$ ${ano['rendaPassivaAtualMes'].toStringAsFixed(2)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]);
                }).toList()
              ]),
        ),
        SizedBox(
          height: 36,
        ),
        ElevatedButton(
          child: Text("Voltar"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ])),
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
