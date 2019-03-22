class SessionUser{

  static String _user;
  static String _token;


  void set setUser(value){
    _user = value;
  }
  void set setToken(value){
    _token = value;
  }

  String get user => _user;
  String get token => _token;

}