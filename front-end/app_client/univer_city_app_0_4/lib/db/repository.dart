import 'package:sqflite/sqflite.dart';
import 'package:univer_city_app_0_4/elements/document_formatting.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';


class DocumentProvider{
  Database db;

  init() async{
    Directory docDir = await getApplicationDocumentsDirectory();
    final path = join(docDir.path, 'info.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDB, int version){
        
      }
    );
  }

}