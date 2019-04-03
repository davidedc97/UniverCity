import 'package:rxdart/rxdart.dart';

class FiltriBloc {

  final BehaviorSubject<int> _filtri = BehaviorSubject<int>(seedValue: 0);

  int get filtriValue => _filtri.value;
  Observable<int> get filtri => _filtri.stream;
  Function(int) get onFiltriChanged => _filtri.sink.add;

  dispose(){
    _filtri.close();
  }
}