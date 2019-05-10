import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Carica'),
        onPressed: () {
          _scegliDocumento(context);
        });
  }

  _scegliDocumento(context) async {
    final String path = await FlutterDocumentPicker.openDocument() ??'';
    debugPrint(path);
    if(path != ''){
      Navigator.of(context).pushNamed('/upload', arguments: <String, String>{
        'path': path,
      });
    }
  }
}
