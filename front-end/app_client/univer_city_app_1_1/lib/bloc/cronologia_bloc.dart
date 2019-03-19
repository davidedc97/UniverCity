import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_1_1/elements/document.dart';

class CronologiaBloc {

  final PublishSubject<List<Document>> _cronologia = PublishSubject<List<Document>>();

  Observable<List<Document>> get cronologia => _cronologia.stream;
  /// TODO ragionare organizzazioni tempo

  fetchData(){
    ///
    /// funzione che inserisce la lista documenti nello stream
    /// che verra invocata nelle fasi di fetch prima di caricare la schermata
    ///
    /// TODO
  }

  dispose(){
    _cronologia.close();
  }
}