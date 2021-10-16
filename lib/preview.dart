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
        Table(
            border: TableBorder.all(width: 1.0, color: Colors.black),
            children: [
              TableRow(children: [
                TableCell(
                  child: Text("Ano"),
                ),
                TableCell(
                  child: Text("Aporte Anual"),
                ),
                TableCell(
                  child: Text("Rendimento Anual"),
                ),
                TableCell(
                  child: Text("Valor Final"),
                ),
                TableCell(
                  child: Text("Renda Passiva Anual"),
                ),
                TableCell(
                  child: Text("Renda Passiva Mensal"),
                ),
              ]),
              ...this.anos.map((ano) {
                return TableRow(children: [
                  TableCell(
                    child: Text(
                      "${this.anos.indexOf(ano) + 1}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${ano['aporteAnual'].toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${ano['rendimentoAnual'].toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${ano['valorFinal'].toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${ano['rendaPassivaAtualAno'].toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${ano['rendaPassivaAtualMes'].toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ]);
              }).toList()
            ]),
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
    );
  }
}
