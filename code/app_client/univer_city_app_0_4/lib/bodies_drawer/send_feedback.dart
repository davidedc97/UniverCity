import 'package:flutter/material.dart';

class SendFeedback extends StatefulWidget {
  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  double _slider1 = 3;
  int _radioVal;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Domanda 1',
                    hintText: 'suggerimento',
                  ),
                ),
                Divider(),
                Text('Domanda 2'),
                Slider(
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
                Divider(),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Domanda 3',
                    hintText: 'suggerimento',
                  ),
                ),
                Divider(),
                Text('Domanda 4'),
                Column(
                  children: <Widget>[
                    ListTile(
                      leading: Radio<int>(
                        value: 0,
                        groupValue: this._radioVal,
                        onChanged: (int value) {
                          setState(() {
                            this._radioVal = value;
                          });
                        },
                      ),
                      title: Text('si'),
                      onTap: () {
                        setState(() {
                          this._radioVal = 0;
                        });
                      },
                    ),
                    ListTile(
                      leading: Radio<int>(
                        value: 1,
                        groupValue: this._radioVal,
                        onChanged: (int value) {
                          setState(() {
                            this._radioVal = value;
                          });
                        },
                      ),
                      title: Text('piu si che no'),
                      onTap: () {
                        setState(() {
                          this._radioVal = 1;
                        });
                      },
                    ),
                    ListTile(
                      leading: Radio<int>(
                        value: 2,
                        groupValue: this._radioVal,
                        onChanged: (int value) {
                          setState(() {
                            this._radioVal = value;
                          });
                        },
                      ),
                      title: Text('piu no che si'),
                      onTap: () {
                        setState(() {
                          this._radioVal = 2;
                        });
                      },
                    ),
                    ListTile(
                      leading: Radio<int>(
                        value: 3,
                        groupValue: this._radioVal,
                        onChanged: (int value) {
                          setState(() {
                            this._radioVal = value;
                          });
                        },
                      ),
                      title: Text('no'),
                      onTap: () {
                        setState(() {
                          this._radioVal = 3;
                        });
                      },
                    ),
                    RaisedButton.icon(
                        color: Colors.amber[200],
                        icon: Icon(Icons.file_upload),
                        label: Text('SEND'),
                        onPressed: ()=>debugPrint('send')
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
