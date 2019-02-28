import 'package:flutter/material.dart';

class SendFeedback extends StatefulWidget {
  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  double _slider1 = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("Che voto daresti all'app?"),
                    Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Slider(
                        inactiveColor: Theme.of(context).accentColor,
                          activeColor: Theme.of(context).accentColor,
                          value: _slider1,
                          min: 1.0,
                          max: 5.0,
                          divisions: 4,
                          label: '${_slider1.round()}',
                          onChanged: (double value) {
                            setState(() {
                              return _slider1 = value;
                            });
                          }),
                    ),
                    Divider(),
                    TextField(
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText:
                            'Quali suggerimenti daresti per migliorarla?',
                      ),
                    ),
                    Divider(),
                    Column(
                      children: <Widget>[
                        RaisedButton.icon(
                            color: Theme.of(context).accentColor,
                            icon: Icon(Icons.file_upload),
                            label: Text('SEND'),
                            onPressed: () => debugPrint('send')),
                      ],
                    ),
                  ],
                ))
          ],
        ));
  }
}
