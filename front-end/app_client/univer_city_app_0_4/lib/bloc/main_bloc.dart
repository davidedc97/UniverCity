import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_0_4/elements/document.dart';


Document info = Document('Telecomunicazioni', 'ing. Giovanni Gianbene', 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf');

class MainBloc{

  //############################################################################gestione home
  //############################################################################preferiti recenti
  final _preferiti = PublishSubject<Document>();
  final _recenti = PublishSubject<Document>();

  //getters allo stream
  Observable<Document> get preferiti => _preferiti.stream;
  Sink<Document> get preferitiSink => _preferiti.sink;

  Observable<Document> get recenti => _recenti.stream;
  Sink<Document> get recentiSink => _recenti.sink;

  final _tema = BehaviorSubject<int>();
  Observable<int> get temaIndex => _tema.stream;
  Sink<int> get temaIndexSink => _tema.sink;




  testFetch(){
    for(int i = 0 ; i<1; i++){
    preferitiSink.add(info);
    recentiSink.add(info);}
  }


  // per eliminare errore di dart perche gli stream
  // dovrebbero essere chiusi prima o poi
  dispose(){
    _preferiti.close();
    _recenti.close();
    _tema.close();
  }
}