import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_1_1/elements/document.dart';
import 'dart:async';

class ProfiloBloc {

  final PublishSubject<List<Document>> _caricatiOriginali = PublishSubject<List<Document>>();
  final PublishSubject<List<Document>> _caricatiMashup = PublishSubject<List<Document>>();

  Observable<List<Document>> get originali => _caricatiOriginali.stream;
  Observable<List<Document>> get mashup => _caricatiMashup.stream;

  fetchData(){
    ///
    /// funzione che inserisce la lista documenti nello stream
    /// che verra invocata nelle fasi di fetch prima di caricare la schermata
    ///
    /// TODO
  }

  dispose(){
    _caricatiMashup.close();
    _caricatiOriginali.close();
  }
}