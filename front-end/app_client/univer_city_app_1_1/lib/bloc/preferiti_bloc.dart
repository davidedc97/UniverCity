import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_1_1/elements/document.dart';
import 'dart:async';

class PreferitiBloc {

  final PublishSubject<List<Document>> _preferiti = PublishSubject<List<Document>>();

  Observable<List<Document>> get preferiti => _preferiti.stream;

  fetchData(){
    ///
    /// funzione che inserisce la lista documenti nello stream
    /// che verra invocata nelle fasi di fetch prima di caricare la schermata
    ///
    /// TODO
  }

  dispose(){
    _preferiti.close();
  }
}