import 'package:flutter/material.dart';

class Page404NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404 not Found ;)'),

      ),
      //TODO reindirizzamenti
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton.icon(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false),
              icon: Icon(Icons.home),
              label: Text('home'),
          ),
          RaisedButton.icon(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false),
            icon: Icon(Icons.fingerprint),
            label: Text('login'),
          ),
          RaisedButton.icon(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/search', (Route<dynamic> route) => false),
            icon: Icon(Icons.search),
            label: Text('search'),
          )
        ],
      ),
    );
  }
}
