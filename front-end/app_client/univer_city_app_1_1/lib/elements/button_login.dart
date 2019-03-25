import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';


///
/// Bottone usato nelle schermate di login
///

class BtnLogin extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;

  BtnLogin(context, {this.title, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    ThemeBloc tBloc = ThemeBlocProvider.of(context);
    return SizedBox(
        width: 300,
        height: 45,
        child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)) ,
            color: color,
            child: Text(title,style: TextStyle(color:(tBloc.state)? Colors.white: Colors.black)),
            onPressed: onPressed));
  }
}