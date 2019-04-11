import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

pdfLoadViewer(BuildContext context, String uuid) async{
  showDialog(
      context: context,
      builder: (context){
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Color(0xFF393E46)),
          child: AlertDialog(
            title: Text('Hey, un attimo non siamo la NASA!', style: TextStyle(color: Colors.white),),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                  ],
                ),
              ],
            ),
          ),
        );
      }
  );
  Uint8List b = await HttpHandler.getDocumentById(uuid);
  if(Navigator.of(context).canPop()){
    Navigator.of(context).pop();
  }
  PdfViewer.loadBytes(b);
}