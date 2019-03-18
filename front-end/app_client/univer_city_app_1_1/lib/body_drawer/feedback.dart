import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Grazie per il feedback :)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.grey,
              )),
          Icon(
            Icons.feedback,
            color: Colors.grey,
            size: 150,
          )
        ],
      ),
    );
  }
}
