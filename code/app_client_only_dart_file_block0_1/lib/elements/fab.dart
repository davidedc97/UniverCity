import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.grey[900],
      child: Icon(Icons.add),
      // callback onPressed #################################################### Da Implementare
      onPressed: _onPressFab(),
    );
  }

  _onPressFab(){
    debugPrint('Fab premuto');
  }

}