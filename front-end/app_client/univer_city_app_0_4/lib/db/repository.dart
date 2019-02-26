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
        CREATE TABLE Favorite(
          title TEXT NOT NULL,
          owner TEXT NOT NULL,
          uuid TEXT PRIMARY KEY,
          
        )
        
        CREATE TABLE History(
          title TEXT NOT NULL,
          owner TEXT NOT NULL,
          uuid TEXT PRIMARY KEY,
          dd INT PRIMARY KEY,
          mm INT PRIMARY KEY,
          yy INT PRIMARY KEY,
          hh INT PRIMARY KEY,
          mm INT PRIMARY KEY,
        )
        ''');
      }
    );
  }

  Future<List<Map<String, dynamic>>> fetchAllPrefDocs() async{
    return db.query('Favorite');
  }

  Future<Document> fetchPrefDoc(String uuid) async{
    final map = await db.query(
      'Favorite',
      columns: null,
      where: 'uuid = ?',
      whereArgs: [uuid],
    );

    if(map.length > 0){
      return Document.fromJson(map.first);
    }
    return null;
  }

  Future<int> addPrefDoc(Document item){
    return db.insert('Favorite', item.toMap());
  }
  
  Future<int> rmPrefDoc(Document item){
    return db.delete(
      'Favorite',
      where: 'uuid = ?',
      whereArgs: [item.uuid],
    );
  }

  //TODO add docs to history

}

