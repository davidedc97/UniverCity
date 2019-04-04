import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_1_1/elements/session_user.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class PreferitiBloc {
  final BehaviorSubject<List<dynamic>> _preferiti =
      BehaviorSubject<List<dynamic>>();
  final BehaviorSubject<int> _num = BehaviorSubject<int>();

  Observable<List<dynamic>> get preferiti => _preferiti.stream;
  Function(List<dynamic>) get onPreferitiChanged => _preferiti.sink.add;

  static List<dynamic> pref = [];

  fetchData() async {
    if (pref.isEmpty) {
      HttpHandler.getUserFavourites(SessionUser().user)
          .then((List<dynamic> list) {
        if (list != null) {
          if (list.isNotEmpty) {
            if (list[0] == '-1' || list[0] == '-2') {
              _preferiti.addError(list[0]);
            } else {
              _num.sink.add(list.length);
              pref = list;
              onPreferitiChanged(list);
            }
          }
        }
      });
    } else {
      onPreferitiChanged(pref);
    }
  }


  dispose() {
    _preferiti.close();
    _num.close();
  }
}
