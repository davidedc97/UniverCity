import 'package:flutter/material.dart';
import 'package:univer_city_app_0_3/elements/doc_card.dart';
import 'package:univer_city_app_0_3/bloc/home_provider.dart';

class ListRecenti extends StatefulWidget {
  @override
  _ListRecentiState createState() => _ListRecentiState();
}

class _ListRecentiState extends State<ListRecenti> {
  List<Widget> recenti = [];
  @override
  Widget build(BuildContext context) {
    final blocHome = HomeProvider.of(context);
    blocHome.recenti.listen((data) {
      setState(() {
        recenti.add(DocCard(data));
      });
    });
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Row(
          children: (recenti.isNotEmpty)
              ?recenti
              :[Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text('Ricordati che devi studiare !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.brown[200],
                  )),
              )
            ],
          )],
        ),
      ],
    );
  }
}