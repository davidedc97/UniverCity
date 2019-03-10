import 'package:flutter/material.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('CARICA'),
        onPressed: () {
          debugPrint('FAB home pressed');
        });
  }
}
