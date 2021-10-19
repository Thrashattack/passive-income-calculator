import 'package:passive_income_calculator/components/container.dart';
import 'package:passive_income_calculator/core/types/history.dart';
import 'package:passive_income_calculator/pages/preview.dart';
import 'package:flutter/material.dart';

class HistoryPage extends DefaultContainer {
  HistoryPage(
      {required List<HistoryType> history, required BuildContext context})
      : super(
            child: history.length == 0
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
                : history.map((item) {
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
                                        PreviewPage(
                                            context: context,
                                            yearsToBigGoal:
                                                item.yearsToBigGoal),
                                  ),
                                ),
                                child: Icon(Icons.remove_red_eye),
                                tooltip: 'Ver Simulação',
                              ),
                            ]));
                  }).toList(),
            title: 'Histórico',
            floatingActionButton: FloatingActionButton(
              heroTag: 'backToHome',
              backgroundColor: Colors.green,
              onPressed: () => Navigator.pop(context),
              tooltip: 'Home',
              child: Icon(Icons.home),
            ));
}
