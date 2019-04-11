import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_1_1/elements/result_search.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class FiltriBloc {

  final BehaviorSubject<int> _filtri = BehaviorSubject<int>(seedValue: 1);
  final BehaviorSubject<List<Result>> _result = BehaviorSubject<List<Result>>();

  static List<Result> _res = [];



  int get filtriValue => _filtri.value;
  Observable<int> get filtri => _filtri.stream;
  Function(int) get onFiltriChanged => _filtri.sink.add;

  Observable<List<Result>> get result => _result.stream;
  Function(List<Result>) get onResult => _result.sink.add;



  searchUser(query) async{
    onResult(null);
    _res = await HttpHandler.search(query, '1');
    onResult(_res);
  }
  searchDoc(query, int filter) async{
    onResult(null);
    _res = await HttpHandler.search(query, '0');
    switch (filter){
      case 1:
        onResult(_res);
        break;
      case 2:
        onResult(_res.where((elem)=>elem?.docInfo?.type==false).toList());
        break;
      case 3:
        onResult(_res.where((elem)=>elem?.docInfo?.type==true).toList());
        break;
    }



  }


  dispose(){
    _filtri.close();
    _result.close();
  }
}