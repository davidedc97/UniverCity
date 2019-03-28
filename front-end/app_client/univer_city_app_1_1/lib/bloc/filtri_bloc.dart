import 'package:rxdart/rxdart.dart';

class FiltriBloc {

  final BehaviorSubject<String> _filtri = BehaviorSubject<String>(seedValue: '');

  String get filtriValue => _filtri.value;
  Observable<String> get filtri => _filtri.stream;
  Function(String) get onFiltriChanged => _filtri.sink.add;

  dispose(){
    _filtri.close();
  }
}