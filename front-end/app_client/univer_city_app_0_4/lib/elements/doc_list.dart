import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/document.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:univer_city_app_0_4/elements/pre_viewer.dart';
import 'dart:typed_data';
import 'package:univer_city_app_0_4/http_handling/http_handler.dart';

class DocList extends StatelessWidget {

  final Document _info;

  DocList(this._info);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title:Text(_info.title),
        subtitle: (_info.owner != null)
            ? Text(_info.owner)
            : Text(''),
        leading: Icon(Icons.description),
        trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context) =>
                      buildDocDialog(context, _info.title, _info.uuid));
              ///showModalBottomSheet(
              /// context: context,
              ///builder: (BuildContext context)=>
              ///     BottomSheetInfoFile(_info.title, _info.owner, _info.uuid)
              ///);
            }
        ),
        onTap: ()async{
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Center(child: CircularProgressIndicator(),),
                );
              }
          );
          Uint8List b = await HttpHandler.getDocumentById(uuid2);
          Navigator.of(context).pop();
          PdfViewer.loadBytes(b);
        },
      ),
    );
  }
}

