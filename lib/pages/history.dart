import 'package:passive_income_calculator/components/container.dart';
import 'package:passive_income_calculator/pages/preview.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final List history;

  History(this.history);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: defaultContainer(
          child: this.history.length == 0
              ? [CircularProgressIndicator()]
              : [
                  ListView.builder(
                    itemCount: this.history.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(this.history[index]['dateCreated']!,
                                    style: TextStyle(fontSize: 20)),
                                FloatingActionButton(
                                  heroTag:
                                      '${this.history[index]['dateCreated']}',
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Preview(this.history[index]['years']
                                              as List<Map<String, double>>),
                                    ),
                                  ),
                                  child: Icon(Icons.remove_red_eye),
                                  tooltip: 'Ver Simulação',
                                ),
                              ]));
                    },
                  )
                ]),
      floatingActionButton: FloatingActionButton(
        heroTag: 'backToHome',
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
