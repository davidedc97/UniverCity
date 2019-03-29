class Document{

  String _title;
  String _creator;
  String _id;
  String _type; // it can be "M" (mashup) or "O" (original)


  Document(this._title, this._creator, this._id, this._type);

  String get title => _title;
  String get creator => _creator;
  String get id => _id;
  String get type => _type;

  Document.fromJson(Map<String, dynamic> json) {
    //funzione-costruttore da usare in http_handler dentro la search_document/get_document
    this._title = json["title"];
    this._creator = json["creator"];
    this._id = json["id"];
    this._type = json["type"];
  }

  @override String toString(){
    return "titolo: " + this.title + "; creatore: " + this.creator + "; id: " + this.id + ", tipo: " + this.type + "\n";
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      'id': _id,
      'title': _title,
      'type': type,
      'creator': _creator
    };
  }

  static List<Document> parseJsonList(int length, List<dynamic> docs){
    List<Document> result = [];
    for(int i=0; i<length; i++){
      result.add(Document.fromJson(docs[i]));
    }
    return result;
  }

}



