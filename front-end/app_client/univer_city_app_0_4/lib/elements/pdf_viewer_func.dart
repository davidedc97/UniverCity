import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:univer_city_app_0_4/http_handling/http_handler.dart';

pdfFuncView(BuildContext context, String uuid) async{
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: Center(child: CircularProgressIndicator(),),
        );
      }
  );
  Uint8List b = await HttpHandler.getDocumentById(uuid);
  Navigator.of(context).pop();
  PdfViewer.loadBytes(b);
}