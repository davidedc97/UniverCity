
//######################################################################################### DocumentInfo
class DocumentInfo{
  String _title;
  String _subtitle;
  String _proprietario, _rank, _downloads;
  //tipo TRUE = SCRITTO A MANO, FALSE = FORMATTATO
  bool _isWrittenByHand;
  String _url;
  DocumentInfo(this._title, this._subtitle, this._proprietario,
               this._rank, this._downloads, this._isWrittenByHand, this._url);

  String get title => _title;
  String get subtitle => _subtitle;
  String get proprietario => _proprietario;
  String get rank => _rank;
  String get downloads => _downloads;
  bool get isWrittenByHand => _isWrittenByHand;
  String get url => _url;

}




