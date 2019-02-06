import 'package:flutter/material.dart';
import 'package:univer_city_app_0_3/elements/document_formatting.dart';
import 'package:univer_city_app_0_3/elements/doc_list.dart';
import 'package:univer_city_app_0_3/elements/title_div.dart';

DocumentInfo info = DocumentInfo('Telecomunicazioni', 'ing. Giovanni Gianbene', 'Giovanni Gianbene',
    '8/10', '1', false, 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf');

class MyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: TitleDivider('This week'),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DocList(info),
              DocList(info),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: TitleDivider('Erlier this month'),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DocList(info),
              DocList(info),
              DocList(info),
              DocList(info),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: TitleDivider('Less recent'),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DocList(info),
              DocList(info),
            ],
          ),
        ),
      ],
    );
  }
}

