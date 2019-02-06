import 'package:flutter/material.dart';
import 'package:univer_city_app_0_3/elements/doc_list.dart';
import 'package:univer_city_app_0_3/bloc/home_provider.dart';

class ListPreferiti extends StatefulWidget {
  @override
  _ListPreferitiState createState() => _ListPreferitiState();
}

class _ListPreferitiState extends State<ListPreferiti> {
  List<Widget> preferiti = <Widget>[];
  @override
  Widget build(BuildContext context) {
    final blocHome = HomeProvider.of(context);
    blocHome.preferiti.listen((data) {
      setState(() {
        preferiti.add(DocList(data));
      });
    });

    return (preferiti.isNotEmpty)
        ?Container(
        color: Colors.white,
        child: Column(
          children:preferiti,
        ))
        :Column(
      children: <Widget>[
        Text('Dai ci sarà qualcosa alla tua altezza, salva qualcosa !',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.brown[200],
            )),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: Icon(Icons.favorite_border,
            color: Colors.brown[200],
            size: 150,
          ))
      ]);
  }
}
