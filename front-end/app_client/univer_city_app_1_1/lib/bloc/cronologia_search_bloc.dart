import 'package:univer_city_app_1_1/elements/cronologia_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

///
/// logica per salvare la cronologia dei documenti visitati nell'app
/// si basa sul pacchetto shared_preferences di flutter per dati persistenti
/// in app.
///

class CronologiaSearchBloc {
  ///
  /// chiave con cui salvo in local storage le entry della cronologia
  ///
  static const String CRONOLOGIA_KEY = 'cronologiaSearch';

  ///
  /// Lista che contiene le entry visualizzate nella pagina drawer
  /// della cronologia
  ///
  final List<CronologiaSearchEntry> _crono = [];

  ///
  /// Stream per la lista in app
  ///
  final BehaviorSubject<List<CronologiaSearchEntry>> _cronologia =
  BehaviorSubject<List<CronologiaSearchEntry>>(seedValue: []);

  ///
  /// questo metodo è invocato durante l'inizializzazione del [BlocProvider]
  /// legge le entry salvate e le reiserisce all'interno della lista [_crono]
  ///
  init() async {
    SharedPreferences cron = await SharedPreferences.getInstance();
    List<String> cr = cron.getStringList(CronologiaSearchBloc.CRONOLOGIA_KEY);
    if (cr != null) {
      for (String e in cr) {
        addInCronologia(CronologiaSearchEntry.fromStored(e));
      }
    }
  }

  ///
  /// getter agli stream e sink
  ///
  Observable<List<CronologiaSearchEntry>> get cronologia => _cronologia.stream;
  List<CronologiaSearchEntry> get cronologiaValue => _cronologia.value;
  Function get onCronologiaChanged => _cronologia.sink.add;

  ///
  /// Funzione per aggiungere un elemento in [_crono] controlla se è
  /// gia presente quel documento in un entry precedente nella cronologia
  /// in caso positivo elimina la vecchia entry e aggiunge la nuova
  /// altrimenti aggiunge senza modificare la lista il documento.
  ///
  addInCronologia(CronologiaSearchEntry e) {
    if(!_crono.any((s)=>s.query==e.query)){
      /// non è presente nessun elemento e in [_crono]
      _crono.add(e);
    }else{
      /// in [_crono] è presente un elemento uguale a e
      _crono.remove(_crono.firstWhere((s)=>s.query==e.query));
      _crono.add(e);
    }
    /// successivamente riordina la lista dalla entry piu recente
    /// alla piu vecchia
    _crono.sort((CronologiaSearchEntry a, CronologiaSearchEntry b) {
      return a.stamp.isBefore(b.stamp) ? 1 : 0;
    });
    /// poi aggiunge [_crono], la lista con le entry della cronologia
    /// allo stream che poi verra usato nello streamBuilder della pagina cronologia
    onCronologiaChanged(_crono);
    ///salva tutto in locale
    _save();
  }

  _save() async {
    SharedPreferences.getInstance().then((SharedPreferences cr) {
      ///
      /// Trasformo la lista [_crono] in una list<String> per poterla salvare
      /// in locale
      ///
      List<String> crList = _crono
          .map((CronologiaSearchEntry e) =>
      '${e.query};${e.stamp.microsecond};${e.stamp.millisecond};${e.stamp.second};${e.stamp.minute};${e.stamp.hour};${e.stamp.day};${e.stamp.month};${e.stamp.year}')
          .toList();
      /// salvo effettivamente la lista in locale
      cr.setStringList(CronologiaSearchBloc.CRONOLOGIA_KEY, crList);
    });
  }

  dispose(){
    _cronologia.close();
  }
}
