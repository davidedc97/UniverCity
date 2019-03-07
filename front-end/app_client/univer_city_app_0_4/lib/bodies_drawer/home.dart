import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/title_div.dart';
import 'package:univer_city_app_0_4/bloc/main_bloc_provider.dart';
import 'package:univer_city_app_0_4/elements/doc_list.dart';
import 'package:univer_city_app_0_4/elements/doc_card.dart';
import 'package:univer_city_app_0_4/elements/document.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Document> _recenti = <Document>[];
  List<Document> _preferiti = <Document>[];

  List<Widget> _reFo = <Widget>[];
  List<Widget> _prFo = <Widget>[];

  @override
  Widget build(BuildContext context) {
    final _blocHome = BlocProvider.of(context);

    _blocHome.preferiti.listen((data) {
      setState(() {
        _preferiti.add(data);
        _prFo.add(DocList(data));
      });
    });
    _blocHome.recenti.listen((data) {
      setState(() {
        _recenti.add(data);
        _reFo.add(DocCard(data));
      });
    });
    //_blocHome.testFetch();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              //Preferiti
              flex: 3,
              child: (_reFo.isNotEmpty)
                  ? ListView.builder(
                      itemCount: _prFo.length,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: TitleDivider('Preferiti'),
                            );
                          default:
                            return _prFo[index - 1];
                        }
                      })
                  : Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: TitleDivider('Qui compariranno i tuoi preferiti'),
                      ),
                      Text(
                          'Dai ci saranno degli appunti alla tua altezza, salva qualcosa !',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Theme.of(context).cardColor,
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: Theme.of(context).cardColor,
                            size: 150,
                          ))
                    ]))
        ]);
  }
}
