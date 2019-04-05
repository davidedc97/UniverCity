class SessionUser{

  static String _user;
  static String _token;
  static List<String> _preferiti = [];


  static set setUser(value){
    _user = value;
  }
  static set setToken(value){
    _token = value;
  }

  static set setPreferiti(dynamic value){
    _preferiti = value;
  }


  static String get user => _user;
  static String get token => _token;
  static List<String> get pref => _preferiti;

}