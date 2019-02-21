import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_0_4/elements/document_formatting.dart';


DocumentInfo info = DocumentInfo('Telecomunicazioni', 'ing. Giovanni Gianbene', 'Giovanni Gianbene',
    '8/10', '1', false, 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf');

class MainBloc{

  //############################################################################gestione home
  //############################################################################preferiti recenti
  final _preferiti = PublishSubject<DocumentInfo>();
  final _recenti = PublishSubject<DocumentInfo>();

  //getters allo stream
  Observable<DocumentInfo> get preferiti => _preferiti.stream;
  Sink<DocumentInfo> get preferitiSink => _preferiti.sink;

  Observable<DocumentInfo> get recenti => _recenti.stream;
  Sink<DocumentInfo> get recentiSink => _recenti.sink;

  testFetch(){
    for(int i = 0 ; i<1; i++){
    preferitiSink.add(info);
    recentiSink.add(info);}
  }

  //############################################################################gestione login
  //############################################################################email password

  final _email = PublishSubject<String>();
  final _password = PublishSubject<String>();

  //getters dellgli stream per form login

  Observable<String> get getPassword  => _password.stream;
  Sink<String> get password => _password.sink;

  Observable<String> get getEmail => _email.stream;
  Sink<String> get email => _email.sink;











  // per eliminare errore di dart perche gli stream
  // dovrebbero essere chiusi prima o poi
  dispose(){
    _preferiti.close();
    _recenti.close();
  }
}