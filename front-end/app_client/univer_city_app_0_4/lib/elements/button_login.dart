import 'package:flutter/material.dart';


///
/// Bottone usato nelle schermate di login
///

class BtnLogin extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;

  BtnLogin({this.title, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 45,
        child: RaisedButton(
            color: color,
            child: Text(title),
            onPressed: onPressed));
  }
}
