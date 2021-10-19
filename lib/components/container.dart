import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:passive_income_calculator/providers/AdManager.dart';

class DefaultContainer extends StatefulWidget {
  final List<Widget> child;

  final FloatingActionButton? floatingActionButton;

  final String title;

  DefaultContainer(
      {required this.title, required this.child, this.floatingActionButton});

  @override
  State<StatefulWidget> createState() {
    return _DefaultContainerState(
        title: title, child: child, floatingActionButton: floatingActionButton);
  }
}

class _DefaultContainerState extends State<DefaultContainer> {
  AdWidget? adWidget;

  String title;

  FloatingActionButton? floatingActionButton;

  List<Widget> child;

  _DefaultContainerState(
      {required this.title, required this.child, this.floatingActionButton});

  @override
  void initState() {
    super.initState();
    AdManager.createAdWidget().then((widget) => setState(() {
          adWidget = widget;
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
            alignment: Alignment.center,
            height: 50,
            color: Colors.blue,
            child: adWidget ?? const SizedBox()),
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
          title: Text(this.title),
        ),
        floatingActionButton: this.floatingActionButton ?? null,
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: this.child,
                ),
              ),
            ),
          );
        }));
  }
}
