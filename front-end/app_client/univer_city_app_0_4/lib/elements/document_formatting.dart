
//######################################################################################### DocumentInfo
class Document{

  String _title;
  String _proprietario;
  String _uuid;


  Document(this._title, this._proprietario, this._uuid );

  String get title => _title;
  String get proprietario => _proprietario;
  String get uuid => _uuid;

  Document.fromJson(Map<String, dynamic> json) {
    //funzione-costruttore da usare in http_handler dentro la search_document
    this._title = json['userId'];
    //etc
  }

}




