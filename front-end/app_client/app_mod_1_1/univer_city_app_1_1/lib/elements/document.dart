class Document{

  String _title;
  String _creator;
  String _uuid;
  bool _type; // it can be "M" (mashup) or "O" (original)


  Document(this._title, this._creator, this._uuid, this._type);

  String get title => _title;
  String get creator => _creator;
  String get uuid => _uuid;
  bool get type => _type;

  Document.fromJson(Map<String, dynamic> json) {
    //funzione-costruttore da usare in http_handler
    this._title = json["title"];
    this._creator = json["creator"];
    this._uuid = json["uuid"];
    this._type = json["type"];
  }

  Document.fromJsonRiccardo(Map<String, dynamic> json) {
    //funzione-costruttore da usare in http_handler
    this._title = json["title"];
    this._creator = json["creator"];
    this._uuid = json["uuid"];
    this._type = json["flag"];
  }

  static List<Document> parseJsonListRiccardo(int length, List<dynamic> docs){
    List<Document> result = [];
    for(int i=0; i<length; i++){
      result.add(Document.fromJsonRiccardo(docs[i]));
    }
    return result;
  }

  static List<Document> parseJsonList(int length, List<dynamic> docs){
    List<Document> result = [];
    for(int i=0; i<length; i++){
      result.add(Document.fromJson(docs[i]));
    }
    return result;
  }

  @override String toString(){
    return "titolo: " + this.title + "; creatore: " + this.creator + "; uuid: " + this.uuid + ", tipo: " + this.type.toString() + "\n";
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      'uuid': _uuid,
      'title': _title,
      'type': type,
      'creator': _creator
    };
  }

}



