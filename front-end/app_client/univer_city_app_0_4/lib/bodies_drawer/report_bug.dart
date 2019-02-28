import 'package:flutter/material.dart';

class ReportBug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text('Grazie per il report',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Theme.of(context).cardColor,
                )),
            Icon(
              Icons.bug_report,
              color: Theme.of(context).cardColor,
              size: 150,
            )
          ],
        )
      ],
    );

  }
}

