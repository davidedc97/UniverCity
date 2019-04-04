import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_1_1/elements/session_user.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:univer_city_app_1_1/elements/document.dart';

class PreferitiBloc {
  final BehaviorSubject<List<dynamic>> _preferiti = BehaviorSubject<List<dynamic>>();
  final BehaviorSubject<int> _num = BehaviorSubject<int>();

  Observable<List<dynamic>> get preferiti => _preferiti.stream;
  List<dynamic> get preferitiValue => _preferiti.value;
  Function(List<dynamic>) get onPreferitiChanged => _preferiti.sink.add;

  // List<String>
  static List<dynamic> pref;

  fetchData() async {
    if (pref==null) {
      HttpHandler.getUserFavourites(SessionUser().user)
          .then((List<dynamic> list) {
            if (list != null) {
              if (list.isNotEmpty) {
                if (list[0] == '-1' || list[0] == '-2' || list[0] == '-3') {
                  _preferiti.addError(list[0]);
                } else {
                  pref = list;
                }}}});
    }
    onPreferitiChanged(pref);
  }

  addFavourite(uuid) async{
    HttpHandler.addUserFavourite(SessionUser().user, uuid)
        .then((res){
          if(res==1){
            pref.add(uuid);
            onPreferitiChanged(pref);
          }//else gestione errore
    });
  }

  removeFavourite(String uuid){
    HttpHandler.removeUserFavourite(SessionUser().user, uuid)
        .then((res){
          if(res==1){
            pref.remove(uuid);
            onPreferitiChanged(pref);
          }//else gestione errore
    });
  }

  dispose() {
    _preferiti.close();
    _num.close();
  }
}
