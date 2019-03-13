class User{

  String _user;
  String _name;
  String _surname;
  String _email;
  String _faculty;
  String _university;
  String _uuid;

  User(this._user, this._name, this._surname, this._email, this._faculty, this._university);

  String get user => _user;
  String get name => _name;
  String get surname => _surname;
  String get email => _email;
  String get faculty => _faculty;
  String get university => _university;
  String get uuid => _uuid;

  User.fromJson(Map<String, dynamic> json) {
    //this function is made to retrieve my own profile (with privacy information)
    this._user = json["user"];
    this._name = json["name"];
    this._surname = json["surname"];
    this._email = json["email"];
    this._faculty = json["faculty"];
    this._university = json["university"];

  }

  User.secureFromJson(Map<String, dynamic> json) {
    // this function is made to retrieve other users' profiles, without privacy information like the email
    this._user = json["user"];
    this._name = json["name"];
    this._surname = json["surname"];
    this._faculty = json["faculty"];
    this._university = json["university"];

  }

}