import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:univer_city_app_1_1/elements/session_user.dart';
import 'package:rxdart/rxdart.dart';

class PreferitiBloc {

  ///
  /// Lista che contiene le entry visualizzate nella pagina drawer
  /// dei preferiti
  ///
  static List<String> _pref = [];

  ///
  /// Stream per la lista in app
  ///
  final BehaviorSubject<List<String>> _preferiti =
  BehaviorSubject<List<String>>.seeded([]);

  ///
  /// questo metodo è invocato durante l'inizializzazione del [BlocProvider]
  /// legge le entry salvate e le reiserisce all'interno della lista [_preferiti]
  ///
  Future<List<dynamic>> init() async {
    return HttpHandler.getUserFavourites(SessionUser.user)
        .then((val){
          _pref = [];
          for(dynamic e in val){
            print('add e in fav');
            _pref.add(e.trim());
          }
          print('init pref ${_pref}');
          onPreferitiChanged(_pref);
          print('Stream notified');
          _save();
        }
    );
  }

  ///
  /// getter agli stream e sink
  ///
  Observable<List<String>> get preferiti => _preferiti.stream;
  List<String> get preferitiValue => _preferiti.value;
  Function get onPreferitiChanged => _preferiti.sink.add;

  ///
  /// Funzione per aggiungere un elemento in [_pref]
  ///
  addInFavourite(dynamic e) {
    print('add fav');
    HttpHandler.addUserFavourite(SessionUser.user, e);
    _pref.add(e);
    onPreferitiChanged(_pref);
    _save();
    print('end add fav');
  }

  ///
  /// Funzione per rimuovere un elemento in [_pref]
  ///
  removeInFavourite(dynamic e) {
    print('rem fav');
    HttpHandler.removeUserFavourite(SessionUser.user, e);
    _pref.remove(e);
    onPreferitiChanged(_pref);
    _save();
    print('end rem fav');
  }

  ///
  /// Funzione per salvare [_pref] in una classe statica usata
  /// per la sessione locale
  ///
  _save() {
    print('save');
    SessionUser.setPreferiti = _pref;
    print('end save');
  }

  dispose(){
    _preferiti.close();
  }
}