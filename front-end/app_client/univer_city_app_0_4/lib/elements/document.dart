class Document{

  String _title;
  String _owner;
  String _uuid;
  String _type; // it can be "M" (mashup) or "O" (original)


  Document(this._title, this._owner, this._uuid, this._type);

  String get title => _title;
  String get owner => _owner;
  String get uuid => _uuid;
  String get type => _type;

  Document.fromJson(Map<String, dynamic> json) {
    //funzione-costruttore da usare in http_handler dentro la search_document/get_document
    this._title = json["title"];
    this._owner = json["creator"];
    this._uuid = json["id"];
    this._type = json["type"];
  }

  @override String toString(){
    return "titolo: " + this.title + "; creatore: " + this.owner + "; id: " + this.uuid + ", tipo: " + this.type + "\n";
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      'title': _title,
      'owner': _owner,
      'uuid': _uuid,
    };
  }

  static List<Document> parseJsonList(List<Map<String, dynamic>> input){
    List<Document> result = [];
    var elem;
    for(elem in input){
      result.add(Document.fromJson(elem));
    }
    return result;
  }

}



