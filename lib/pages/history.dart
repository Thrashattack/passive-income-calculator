import 'package:passive_income_calculator/components/container.dart';
import 'package:passive_income_calculator/logic/types/history.dart';
import 'package:passive_income_calculator/pages/preview.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final List<HistoryType> history;

  History(this.history);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: defaultContainer(
          child: this.history.length == 0
              ? [
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Text("Nenhum registro ainda...",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ]
              : this.history.map((item) {
                  return Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.dateCreated,
                                style: TextStyle(fontSize: 20)),
                            FloatingActionButton(
                              heroTag: '${item.dateCreated}',
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      Preview(item.years),
                                ),
                              ),
                              child: Icon(Icons.remove_red_eye),
                              tooltip: 'Ver Simulação',
                            ),
                          ]));
                }).toList()),
      floatingActionButton: FloatingActionButton(
        heroTag: 'backToHome',
        backgroundColor: Colors.green,
        onPressed: () => Navigator.pop(context),
        tooltip: 'Home',
        child: Icon(Icons.home),
      ),
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
    );
  }
}
