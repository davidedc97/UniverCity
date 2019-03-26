import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {

  final String _title;
  TitleDivider(this._title);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0),
          child: Text(_title, textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0,color: Theme.of(context).accentColor),),
        )
    );
  }
}