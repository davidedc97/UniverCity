import 'package:univer_city_app_1_1/elements/cronologia_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// logica per salvare la cronologia dei documenti visitati nell'app
/// si basa sul pacchetto shared_preferences di flutter per dati persistenti
/// in app.
///

class CronologiaBloc {

  static const String CRONOLOGIA_KEY = 'cronologia';
  final List<CronologiaEntry> _cronologia = [];

  ///
  /// questo metodo è invocato durante l'inizializzazione del [BlocProvider]
  /// riceve come input la lista di tuute le [CronologiaEntry] per poi metterle
  /// all'interno della lista [_cronologia]
  ///

  init(List<CronologiaEntry> entries) async{
    SharedPreferences cron = await SharedPreferences.getInstance();
    List<String> cr = cron.getStringList(CronologiaBloc.CRONOLOGIA_KEY);

    Map<String, CronologiaEntry> entriesMap = Map();
    for(CronologiaEntry e in entries){
      entriesMap.putIfAbsent(e.uuid, ()=>e);
    }
    if(cr != null){
      for(String c in cr){
        CronologiaEntry entry = entriesMap[c];
        if(entry != null){
          _cronologia.add(entry);
        }
      }
    }
    _cronologia.sort((CronologiaEntry a, CronologiaEntry b){
      return a.stamp.compareTo(b.stamp);
    });
  }

  List<CronologiaEntry> get cronologia => _cronologia;

  addInCronologia(CronologiaEntry e){
    this._cronologia.add(e);
    _cronologia.sort((CronologiaEntry a, CronologiaEntry b){
      return a.stamp.compareTo(b.stamp);
    });
    _save();
  }

  _save(){
    SharedPreferences.getInstance().then((SharedPreferences cr){
      List<String> crList = _cronologia.map((CronologiaEntry e)=> e.uuid).toList();
      cr.setStringList(CronologiaBloc.CRONOLOGIA_KEY, crList);
    });
  }


}