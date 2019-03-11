import 'package:flutter/material.dart';

class Ordina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 16,
            bottom: 18,
            child: FloatingActionButton.extended(
                onPressed: (){debugPrint('carica');},
                icon: Icon(Icons.add),
                label: Text('CARICA')),
          )
        ],
      ),
    );
  }
}
