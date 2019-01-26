import 'package:flutter/material.dart';
import 'package:univer_city_app_block0_1/ui_pages/main_scaffold.dart';

void main() => runApp(UniverCity());

class UniverCity extends StatelessWidget {
// per disabilitare il layout orizzontale################################### DISAB LAYOUT ORIZZONTALE
 //<TODO>
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniverCity PREALPHA',
      theme: ThemeData(
        primaryColor: Colors.pink[900],
        primaryColorLight: Color.fromARGB(255, 188, 71, 123),
        primaryColorDark: Color.fromARGB(255, 148, 2, 70),
      ),
      home: MainScaffold(),
    );
  }
}