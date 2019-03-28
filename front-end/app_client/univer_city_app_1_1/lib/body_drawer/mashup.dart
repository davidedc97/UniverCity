import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';

class Mashup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: MashSfondo(),);
  }
}

class MashSfondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: TitleDivider('Qui compariranno tutti i tuoi mashup'),
      ),
      Text(
          ' Hey datti una mossa !',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.grey,
          )),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: Icon(
            Icons.insert_drive_file,
            color: Colors.grey,
            size: 150,
          ))
    ]);
  }
}