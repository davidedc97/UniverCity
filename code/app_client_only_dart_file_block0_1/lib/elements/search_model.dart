import 'package:scoped_model/scoped_model.dart';

// Classe SearchModel chr tiene traccia dello stato del main per
// fargli capire se l'utente ha premuto l'icona per cercare oppure no

class SearchModel extends Model{
  // ###########################################################################STATO
  bool _isSearching = false;

  //############################################################################GetterStato
  bool get isSearching => _isSearching;

  //############################################################################SetterStato
  void searching(bool b){
    _isSearching = b;
    //##############################Notifica a chi è in scolto per questo stato che è cambiato
    //##############################Importante altrimenti non refresha la pagina
    notifyListeners();
  }
}