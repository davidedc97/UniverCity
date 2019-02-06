import 'package:flutter/material.dart';

class ReportBug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              TextField(
                maxLines: 12,
                decoration: InputDecoration(
                  labelText: 'Descrizione del bug',
                  hintText: 'suggerimento',
                ),
              ),
              RaisedButton.icon(
                  color: Colors.amber[200],
                  onPressed: ()=>debugPrint('send'),
                  icon: Icon(Icons.bug_report),
                  label: Text('SEND')
              ),
            ],
          )
        ],
      ),
    );
  }
}

