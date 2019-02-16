import 'package:flutter/material.dart';

import 'package:document_chooser/document_chooser.dart';


//############################################################################## Classe stora i dati di un bottone
class ButtonSheet {
  IconData _ico;
  String _title;
  ButtonSheet(this._title, this._ico);
}

//############################################################################## Lista dei bottoni nel bottom sheet
List<ButtonSheet> _buttons = [
  ButtonSheet('Upload', Icons.cloud_upload),
  ButtonSheet('Scans', Icons.camera_alt)
];


class BottomSheetUpload extends StatelessWidget {

  final BuildContext _contextSc;
  BottomSheetUpload(this._contextSc);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///
          /// Da qui ci sono due Column, all' interno ci sono gli elementi
          /// per un bottone, quindi icona e titolo
          ///
          /// FromDeviceBtn
          ///
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: IconButton(
                    icon: Icon(
                      _buttons[0]._ico,//referenzia alla lista in cima
                      size: 48.0,
                    ),
                    onPressed:(){
                      _fromDevice();
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  _buttons[0]._title,//referenzia alla lista in cima
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              )
            ],
          ),
          ///
          /// FromCameraBtn
          ///
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: IconButton(
                    icon: Icon(
                      _buttons[1]._ico,//referenzia alla lista in cima
                      size: 48.0,
                    ),
                    onPressed: (){
                      _fromCamera(_contextSc);
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  _buttons[1]._title,//referenzia alla lista in cima
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

//############################################################################## From Device
_fromDevice() async{
  String path = await DocumentChooser.chooseDocument();
  debugPrint(path);
  //TODO Navigator per gestione tag upload

}
//############################################################################## From Camera
_fromCamera(context) async{
  Navigator.pop(context);
  final _snak = SnackBar(content: Text('ci stiamo ancora lavorando! ;) '));
  Scaffold.of(context).showSnackBar(_snak);
  debugPrint('from camera');
}



