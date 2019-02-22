class Document{

  String _title;
  String _owner;
  String _uuid;


  Document(this._title, this._owner, this._uuid );

  String get title => _title;
  String get owner => _owner;
  String get uuid => _uuid;

  Document.fromJson(Map<String, dynamic> json) {
    //funzione-costruttore da usare in http_handler dentro la search_document/get_document
    this._title = json["title"];
    this._owner = json["owner"];
    this._uuid = json["uuid"];
  }

}




