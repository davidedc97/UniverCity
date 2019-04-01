import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_1_1/elements/session_user.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class PreferitiBloc {

  final BehaviorSubject<List<String>> _preferiti = BehaviorSubject<List<String>>();
  final BehaviorSubject<int> _num = BehaviorSubject<int>();

  Observable<List<String>> get preferiti => _preferiti.stream;
  Function(List<String>) get onPreferitiChanged => _preferiti.sink.add;

  fetchData()async{
    HttpHandler.getUserFavourites(SessionUser().user).then((List<String> list){
      if(list != null){
        if(list.isNotEmpty){
          if(list[0]=='-1'||list[0]=='-2'){
            _preferiti.addError(list[0]);
          }
          else{
            _num.sink.add(list.length);
            onPreferitiChanged(list);
          }
        }
      }
    });
  }

  dispose(){
    _preferiti.close();
    _num.close();
  }
}