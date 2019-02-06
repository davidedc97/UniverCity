import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_0_3/elements/document_formatting.dart';


DocumentInfo info = DocumentInfo('Telecomunicazioni', 'ing. Giovanni Gianbene', 'Giovanni Gianbene',
    '8/10', '1', false, 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf');

class HomeBloc{
  final _preferiti = PublishSubject<DocumentInfo>();
  final _recenti = PublishSubject<DocumentInfo>();

  //getters allo stream
  Observable<DocumentInfo> get preferiti => _preferiti.stream;
  Sink<DocumentInfo> get preferitiSink => _preferiti.sink;

  Observable<DocumentInfo> get recenti => _recenti.stream;
  Sink<DocumentInfo> get recentiSink => _recenti.sink;

  test(){
    for(int i = 0 ; i<1; i++){
    preferitiSink.add(info);
    recentiSink.add(info);}
  }
  // per eliminare errore di dart perche gli stream
  // dovrebbero essere chiusi prima o poi
  dispose(){
    _preferiti.close();
    _recenti.close();
  }
}