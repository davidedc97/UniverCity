import 'package:sqflite/sqflite.dart';
import 'package:univer_city_app_0_4/elements/document.dart';
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
        newDB.execute('''
        CREATE TABLE Documents(
          title TEXT NOT NULL,
          owner TEXT NOT NULL,
          uuid TEXT PRIMARY KEY,
        )
        ''');
      }
    );
  }

  fetchAllPrefDocs() async{
    return db.query('Documents');
  }

  fetchPrefDoc(String uuid) async{
    final map = await db.query(
      'Documents',
      columns: null,
      where: 'uuid = ?',
      whereArgs: [uuid],
    );

    if(map.length > 0){
      return Document.fromJson(map.first);
    }
    return null;
  }

  addPrefDoc(Document item){
    db.insert('Documents', item.toMap());
  }
  
  rmPrefDoc(Document item){
    db.delete(
      'Documents',
      where: 'uuid = ?',
      whereArgs: [item.uuid],
    );
  }
}