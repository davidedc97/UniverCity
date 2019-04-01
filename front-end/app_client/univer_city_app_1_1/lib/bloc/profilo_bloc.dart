import 'package:rxdart/rxdart.dart';
import 'package:univer_city_app_1_1/elements/document.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:univer_city_app_1_1/elements/user.dart';
import 'package:univer_city_app_1_1/elements/session_user.dart';

class ProfiloBloc {

  final BehaviorSubject<List<Document>> _caricatiOriginali = BehaviorSubject<List<Document>>();
  final BehaviorSubject<List<Document>> _caricatiMashup = BehaviorSubject<List<Document>>();
  final BehaviorSubject<int> _xp = BehaviorSubject<int>(seedValue: 0);
  final BehaviorSubject<String> _bio = BehaviorSubject<String>(seedValue: 'L\'utente non ha condiviso nessuna descrizione');
  final PublishSubject<String> _img = PublishSubject<String>();
  final PublishSubject<String> _user = PublishSubject<String>();
  final PublishSubject<String> _facolta = PublishSubject<String>();

  Observable<List<Document>> get originali => _caricatiOriginali.stream;
  Observable<List<Document>> get mashup => _caricatiMashup.stream;
  Observable<int> get xp => _xp.stream;
  Observable<String> get bio => _bio.stream;
  Observable<List<String>> get headProfile => Observable.combineLatest3(_user, _facolta, _bio, (us, fa, img)=>[us,fa,img]);

  List<Document> get originaliValue => _caricatiOriginali.value;
  List<Document> get mashupValue => _caricatiMashup.value;
  int get xpValue => _xp.value;
  String get bioValue => _bio.value;




  fetchData(String u)async{
    String uString =  u ?? SessionUser().user;
    User utente = await HttpHandler.getUserData(uString);
    _xp.sink.add(utente.xp);
    _bio.sink.add(utente.bio);
    _img.sink.add(utente.img);
    _user.sink.add(utente.user);
    _facolta.sink.add(utente.faculty);
    _caricatiOriginali.sink.add(_docListFromJson(utente.documentUploaded));
    _caricatiMashup.sink.add(_docListFromJson(utente.mashupCreated));
  }

  List<Document> _docListFromJson(Map<String,dynamic> m){
    //var l = m['num'];
    //List<dynamic> docs = m['docs'];
    //List<Document> documentList = Document.parseJsonList(l,docs);
    return <Document>[];//documentList;
  }

  dispose(){
    _caricatiMashup.close();
    _caricatiOriginali.close();
    _xp.close();
    _bio.close();
    _img.close();
    _user.close();
    _facolta.close();
  }
}