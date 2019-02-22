class User{

  String _user;
  String _name;
  String _surname;
  String _email;
  String _password;
  String _faculty;
  String _university;

  User(this._user, this._name, this._surname, this._email, this._password);

  String get user => _user;
  String get name => _name;
  String get surname => _surname;
  String get email => _email;
  //String get password => _password;
  String get faculty => _faculty;
  String get university => _university;

  User.fromjson(Map<String, dynamic> json) {
    this._user = json["user"];
    this._name = json["name"];
    this._surname = json["surname"];
    this._email = json["email"];

  }

}