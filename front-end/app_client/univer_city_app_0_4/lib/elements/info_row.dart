import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String _title, _data;
  InfoRow(this._title, this._data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_title),
          Text(_data),
        ],
      ),
    );
  }
}