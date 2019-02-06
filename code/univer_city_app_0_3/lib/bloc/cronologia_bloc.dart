import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_0_3/elements/document_formatting.dart';

class CronologiaBloc{
  final _week = PublishSubject<DocumentInfo>();
  final _month = PublishSubject<DocumentInfo>();
  final _erlier = PublishSubject<DocumentInfo>();

  //getters allo stream
  Observable<DocumentInfo> get weekHistory => _week.stream;
  Sink<DocumentInfo> get weekSink => _week.sink;

  Observable<DocumentInfo> get monthHistory => _month.stream;
  Sink<DocumentInfo> get monthSink => _month.sink;

  Observable<DocumentInfo> get erlierHistory => _erlier.stream;
  Sink<DocumentInfo> get erlierSink => _erlier.sink;



  // per eliminare errore di dart perche gli stream
  // dovrebbero essere chiusi prima o poi
  dispose(){
    _week.close();
    _erlier.close();
    _month.close();
  }
}