import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:univer_city_app_1_1/elements/session_user.dart';
import 'package:rxdart/rxdart.dart';

class MashupBloc {

  ///
  /// Lista che contiene le entry visualizzate nella pagina drawer
  /// dei preferiti
  ///
  static List<String> _mash = [];

  ///
  /// Stream per la lista in app
  ///
  final BehaviorSubject<List<String>> _mashup =
  BehaviorSubject<List<String>>.seeded([]);

  ///
  /// questo metodo è invocato durante l'inizializzazione del [BlocProvider]
  /// legge le entry salvate e le reiserisce all'interno della lista [_preferiti]
  ///
  Future<List<dynamic>> init() async {
    return HttpHandler.getUserMashup(SessionUser.user)
        .then((val){
      _mash = [];
      for(dynamic e in val){
        print('add e in fav');
        _mash.add(e.trim());
      }
      print('init pref ${_mash}');
      onMashupChanged(_mash);
      print('Stream notified');
    }
    );
  }

  ///
  /// getter agli stream e sink
  ///
  Observable<List<String>> get mashup => _mashup.stream;
  List<String> get mashupValue => _mashup.value;
  Function get onMashupChanged => _mashup.sink.add;


  dispose(){
    _mashup.close();
  }
}