import 'package:flutter/material.dart';

/// Classe che visualizza a schermo il divider ----------OR---------
/// usato nella schermata di login

class DividerTextOr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 1.5,
            width: 120,
            color: Colors.grey,
            margin: EdgeInsets.only(right: 12),
          ),
          Text('OR'),
          Container(
            height: 1.5,
            width: 120,
            color: Colors.grey,
            margin: EdgeInsets.only(left: 12),
          ),
        ],
      ),
    );
  }
}
