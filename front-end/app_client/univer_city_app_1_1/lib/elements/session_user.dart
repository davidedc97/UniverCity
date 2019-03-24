class SessionUser{

  static String _user;
  static String _token;


  set setUser(value){
    _user = value;
  }
  set setToken(value){
    _token = value;
  }

  String get user => _user;
  String get token => _token;

}