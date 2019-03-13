import 'package:flutter/material.dart';

///
/// UndoButton
///
class UndoButton extends StatelessWidget {
  final String route;
  UndoButton({this.route});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 8,
        top: 32,
        child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(route??'/', (Route<dynamic> route) => false)));
  }
}


