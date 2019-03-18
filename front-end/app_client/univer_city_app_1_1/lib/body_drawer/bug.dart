import 'package:flutter/material.dart';

class Bug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Grazie per la segnalazione :)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.grey,
              )),
          Icon(
            Icons.bug_report,
            color: Colors.grey,
            size: 150,
          )
        ],
      ),
    );
  }
}
