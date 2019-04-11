import 'package:flutter/material.dart';

class LevelBar extends StatelessWidget {
  final int levelInfo;
  LevelBar(this.levelInfo);
  @override
  Widget build(BuildContext context) {

    //Calcolo del livello e della barra progresso del livello

    double progressLevel = (levelInfo%1000)/1000;
    int level = levelInfo~/1000;
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Livello'),
              leading: Text(
                level.toString(),
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            LinearProgressIndicator(
                value: progressLevel,
                backgroundColor:
                Theme.of(context).accentColor.withAlpha(77))
          ],
        ),
      ),
    );
  }
}
