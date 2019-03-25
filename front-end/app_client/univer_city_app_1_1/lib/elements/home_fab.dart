import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/upload_bloc_provider.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc tBlock = ThemeBlocProvider.of(context);
    return FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('CARICA'),
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
