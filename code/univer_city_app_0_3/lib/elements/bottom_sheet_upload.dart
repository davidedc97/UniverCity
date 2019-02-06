import 'package:flutter/material.dart';

class BottomSheetUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      color: Colors.white,
      child: _buttonsRow(_buttons),
    );
  }
}

//############################################################################## Classe stora i dati di un bottone
class ButtonSheet {
  IconData _ico;
  String _title;
  var _callback;
  ButtonSheet(this._title, this._ico, this._callback);
}

//############################################################################## Lista dei bottoni nel bottom sheet
List<ButtonSheet> _buttons = [
  ButtonSheet('Upload', Icons.cloud_upload, () => debugPrint('device pressed')),
  ButtonSheet('Scans', Icons.camera_alt, () => debugPrint('camera pressed'))
];

//############################################################################## Widget con i bottoni formattati
Widget _buttonsRow(List<ButtonSheet> buttons) {
  List<Widget> _btt = <Widget>[];
  //############################################################################ Creo i bottoni e li aggiungo in _btt
  for (var i = 0; i < buttons.length; i++) {
    _btt.add(Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: IconButton(
              icon: Icon(
                buttons[i]._ico,
                size: 48.0,
              ),
              onPressed: buttons[i]._callback),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            buttons[i]._title,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        )
      ],
    ));
  }

  //############################################################################ Ritornno i bottoni formattati
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: _btt,
  );
}
