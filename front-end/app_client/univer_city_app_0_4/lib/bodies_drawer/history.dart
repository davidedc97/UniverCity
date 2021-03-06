import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/document.dart';
import 'package:univer_city_app_0_4/elements/doc_list.dart';
import 'package:univer_city_app_0_4/elements/title_div.dart';

Document info1 = Document('Test 1', 'Un tizio','bc4c22e0-4131-11e9-b732-1f3eec9d2cde', 'O');
Document info2 = Document('Test 2', 'Un altro tizio','bc4c22e0-4131-11e9-b732-1f3eec9d2cde', 'O');
Document info3 = Document('Test 3', 'Un altro ancora','bc4c22e0-4131-11e9-b732-1f3eec9d2cde', 'O');

class MyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: TitleDivider('Questa settimana'),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DocList(info1),
              DocList(info1),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: TitleDivider('Questo mese'),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DocList(info2),
              DocList(info2),
              DocList(info2),
              DocList(info2),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: TitleDivider('Meno recenti'),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DocList(info3),
              DocList(info3),
            ],
          ),
        ),
      ],
    );
  }
}

