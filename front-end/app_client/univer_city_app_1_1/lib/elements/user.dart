class User{

  String _user;
  String _name;
  String _surname;
  String _email;
  String _faculty;
  String _university;
  String _img;
  int _xp;
  String _bio;
  Map<String, dynamic> _documentUploaded;
  Map<String, dynamic> _mashupCreated;

  User(this._user, this._name, this._surname, this._email, this._faculty, this._university);

  String get user => _user;
  String get name => _name;
  String get surname => _surname;
  String get email => _email;
  String get faculty => _faculty;
  String get university => _university;
  String get img => _img;
  int get xp => _xp;
  String get bio => _bio;
  Map<String, dynamic> get documentUploaded =>_documentUploaded;
  Map<String, dynamic> get mashupCreated => _mashupCreated;



  User.fromJson(Map<String, dynamic> json) {
    //this function is made to retrieve my own profile (with privacy information)
    this._user = json["username"];
    this._name = json["name"];
    this._surname = json["surname"];
    this._faculty = json["faculty"];
    this._university = json["university"];

  }

  User.metadataFromJson(Map<String, dynamic> json){
    this._user = json["username"];
    this._name = json["name"];
    this._bio = json["bio"];
    this._surname = json["surname"];
    this._faculty = json["faculty"];
    this._university = json["university"];
    this._img = json["imgUserPath"];
    this._xp = json["xp"];
    this._documentUploaded = json["documentUploaded"];
    this._mashupCreated = json["mashupCreated"];
  }

  User.secureFromJson(Map<String, dynamic> json) {
    // this function is made to retrieve other users' profiles, without privacy information like the email
    this._user = json["username"];
    this._name = json["name"];
    this._surname = json["surname"];
    this._faculty = json["faculty"];
    this._university = json["university"];

  }

  static List<User> parseJsonList(int length, List<dynamic> users){
    List<User> result = [];
    for(int i=0; i<length; i++){
      result.add(User.fromJson(users[i]));
    }
    return result;
  }

  toString(){
    return '$_user $_xp $faculty $_img ';
  }

}