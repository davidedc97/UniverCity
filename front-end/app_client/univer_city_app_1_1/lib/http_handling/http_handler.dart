import 'package:http/http.dart' as http;
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

import 'package:univer_city_app_1_1/elements/session_user.dart';

class HttpHandler {
  static String _sessionToken;
  static const _URL = "https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev";
  static const _FAKE_LOG_URL = "https://v1uu1cu9ld.execute-api.eu-west-1.amazonaws.com/alpha";
  static const _DOCUMENT_SERVER = "/document";
  static const _DOCUMENT_METADATA = "/documentMetadata";
  static const _SEARCH_USER_SERVER = "/searchUser";
  static const _SEARCH_DOC_SERVER = "/searchDocument";
  static const _USER_DATA = "/userData";
  static const _USER_IMG = "/userImg";
  static const _USER_ADD_EXP = "/addUserExperience";
  static const _USER_BIO = "/userBio";
  static const _LOGIN_SERVER = "/userLog";
  static const _REG_SERVER = "/userReg";
  static const _LIKE_SERVER = "/like";
  static const _MASHUP_SERVER = "/mashup";

  //TODO (Davide) FUNZIONI DA RIVEDERE: getMyUserById, getOtherUserById, downloadDocument
  
                                /*########     USER  HANDLING     ########*/


  /*
    ** This function returns:
    **   1 if the user is correctly added to the Db
    **  -1 if the user is already in the Db or invalid form
    **  -2 if there's an internal error
    **  throws an exception otherwise
  */
  static Future<int> userFormRegistration(String user,String name,String surname,String email,String pw,String faculty,String university) async {
    final response =
      await http.post(
        _FAKE_LOG_URL + _REG_SERVER,
        headers:{
                 'Content-type' : 'application/json',
                 'Accept': 'application/json',
                },
        body: json.encode({"username": user, 
                           "name": name, 
                           "surname": surname, 
                           "email": email, 
                           "pass": pw, 
                           "faculty": faculty, 
                           "university":university
                          }));

    print(response.statusCode);

    if(response.statusCode == 200) {
      return 1;
    }
    else if(response.statusCode == 400 || response.statusCode == 409) {
      return -1;
    }
    else if(response.statusCode == 500) {
      return -2;
    }
    else {
      throw ServerException.withCode(response.statusCode);
    }
  }

  /*
    ** This function returns:
    **   1 if the user is in the Db and the password is correct
    **  -1 invalid login
    **  -2 if there's an internal error
    **  throws an exception otherwise
    ** The value of flag must be "0" (user is login in with username) or "1" (user is login in with email)
  */
  static Future<int> validateLogin(String user, String pw,String flag) async {
    SessionUser().setUser = user;

    final response =
      await http.post(
          _FAKE_LOG_URL+_LOGIN_SERVER,
        headers:{
          'Content-type' : 'application/json',
          'Accept': 'application/json',
        },
        body:json.encode({"username":user,"pass": pw})
            );
    print(response.statusCode);
    print('BODY :' + response.body);

    if(response.statusCode == 200) {
      _sessionToken = response.headers['token'];
      SessionUser().setToken = _sessionToken;
      return 1;
    }
    else if(response.statusCode == 400 || response.statusCode == 403) {
      return -1;
    }
    else if(response.statusCode == 500) {
      return -2;
    }
    else {
      throw ServerException.withCode(response.statusCode);
    }
  }

  static Future<User> getUserData(String user) async {
    final response =
      await http.get(
        _URL+_USER_DATA + "?username=" + user,
        headers:{
          'Authorization':_sessionToken,
          'Content-type' : 'application/json',
          'Accept': 'application/json',
        }
    );

    print(response.statusCode);
    print('BODY :' + response.body);

    if(response.statusCode == 200) {
      return User.metadataFromJson(json.decode(response.body));
    }
    else if(response.statusCode == 404) {
      print("############### UTENTE NON TROVATO");
    }
    else if(response.statusCode == 500) {
      print("############### SERVER INTERNAL ERROR");
    }

  }

  static Future<Uint8List> getUserImg(String user) async {
    final response =
    await http.get(
        _URL+_USER_IMG + "?username=" + user,
        headers:{
          'Authorization':_sessionToken,
          'Content-type' : 'application/json',
          'Accept': 'application/img',
        }
    );

    print(response.statusCode);
    print('BODY :' + response.body);

    if(response.statusCode == 200) {
      return response.bodyBytes;
    }
    else if(response.statusCode == 500) {
      print("############### SERVER INTERNAL ERROR");
    }

  }

  static Future<int> changeUserImg(String user, String file) async {
    final response =
    await http.put(
        _URL + _USER_IMG,
        headers:{
          'Authorization':_sessionToken,
          'Content-type' : 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          "username": user,
          "file": file
        }));
    if(response.statusCode == 200){
      // img succesfully uploaded
      return 1;
    }
    else if(response.statusCode == 400){
      // bad input
      return -1;
    }
    else if(response.statusCode == 500){
      // server internal error
      return -2;
    }
  }

  static Future<int> addUserExp(String user, int expToAdd) async {
    final response =
    await http.put(
        _URL + _USER_ADD_EXP,
        headers:{
          'Authorization':_sessionToken,
          'Content-type' : 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          "username": user,
          "xp": expToAdd
        }));
    if(response.statusCode == 200){
      // exp succesfully added
      return 1;
    }
    else if(response.statusCode == 400){
      // bad input
      return -1;
    }
    else if(response.statusCode == 500){
      // server internal error
      return -2;
    }
  }

  static Future<int> changeUserBio(String user, String bio) async {
    final response =
    await http.put(
        _URL + _USER_BIO,
        headers:{
          'Authorization':_sessionToken,
          'Content-type' : 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          "username": user,
          "bio": bio
        }));
    if(response.statusCode == 200){
      // bio succesfully uploaded
      return 1;
    }
    else if(response.statusCode == 400){
      // bad input
      return -1;
    }
    else if(response.statusCode == 500){
      // server internal error
      return -2;
    }
  }

  static Future<User> getMyUserById(String userId) async {
    final response =
    await http.get(_URL + _LOGIN_SERVER + "/" + userId);
    if(response.statusCode == 200){
      return User.fromJson(json.decode(response.body));
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }

  static Future<User> getOtherUserById(String userId) async {
    final response =
        await http.get(_URL + _LOGIN_SERVER + "/" + userId);
    if(response.statusCode == 200){
      return User.secureFromJson(json.decode(response.body));
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


                                /*########     DOCUMENT  HANDLING     ########*/


  /*
    ** This function returns:
    **   1 if the document is succesfully uploaded
    **  -1 if there's a bad input parameter
    **  -2 if there's an internal error
    **  throws an exception otherwise
    **
  */
  static Future<int> uploadDocument(String title, List<String> tags, String typeFlag, String creator, String path) async {

    print('####################################################################$title ,$path');
    print(_sessionToken);
    var res;
    String _t = title;
    var uri = Uri.parse(_URL + _DOCUMENT_SERVER);
    var request = new http.MultipartRequest('POST', uri);
    var file = await http.MultipartFile.fromPath('package', path);

    request.headers.addAll({"Authorization":_sessionToken});
    request.fields.addAll({"title":_t.toString(), "tags": tags.toString(), "type": typeFlag, "creator": creator});
    request.files.add(file);

    await request.send().then( (response) {
      res = response;
    });

    print(res.statusCode);

    if (res.statusCode == 201) {
      // document created
      // nel response.body viene tornato id, titolo, tipo e creatore del documento
      return 1;
    }
    else if (res.statusCode == 400){
      //debugPrint('up2');
      return -1;
    }
    else if (res.statusCode == 500){
      //debugPrint('up3');
      return -2;
    }
    else{
      //debugPrint('up4');
      return -3;
    }
  }

  static Future<Uint8List> getDocumentById( String docId ) async{
    final response =
      await http.get(
          _URL + _DOCUMENT_SERVER + "?id=" + docId,
          headers: {'Authorization':_sessionToken ,'Content-type' : 'application/json', 'Accept': 'application/pdf'} //qui era "application/json" e funzionava
          );

    print(response.statusCode);

    if(response.statusCode == 200) {
      return response.bodyBytes;
    }
    else{
      return null; //TODO: soluzione provvisoria in caso di errore
    }
  }

  static Future<Document> getDocumentMetadata(String docId) async{
    final response =
      await http.get(
        _URL + _DOCUMENT_METADATA + "?id=" + docId,
        headers: {'Authorization':_sessionToken ,'Content-type' : 'application/json', 'Accept': 'application/json'}
    );

    print(response.statusCode);

    if(response.statusCode == 200) {
      return Document.fromJson(json.decode(response.body));
    }
    else{
      return null; //TODO: soluzione provvisoria in caso di errore
    }
  }

  //TODO: devo capire come cazzo si fa
  static Future<int> downloadDocument(String docId, String path) async {
    print('scarico');
    var response =
        await http.get(_URL + _DOCUMENT_SERVER + "?id=" + docId, headers: {'Authorization':_sessionToken});

    if(response.statusCode == 200){
      File f = new File(path);
      f.writeAsBytes(response.bodyBytes);
      print('ok');
      return 1;
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }

  //TODO: si può cambiare il tipo di pagesData in List<Page>
  static Future<dynamic> mashup(String title, List<String> tags, String creator, List<Map<String, dynamic>> pagesData) async {
    final response =
        await http.post(
          _URL + _MASHUP_SERVER,
          body:{
            "title": json.encode(title),
            "tags": json.encode(tags),
            "creator": json.encode(creator),
            "pages": json.encode(pagesData)
          });

    if(response.statusCode == 201) {
      // succesfully created
      return 1;
    }
    else if(response.statusCode == 400){
      print("#############  bad input parameter");
      return -1;
    }
    else if(response.statusCode == 404){
      print("#############  one or more pages don't exist");
      return -2;
    }
    else if(response.statusCode == 500){
      print("#############  server internal error");
      return -3;
    }
  }


                                /*########     SEARCH  HANDLING     ########*/


  /*
    ** This function returns a list of documents/users fitting the query
    ** The value of typeFlag must be "0" (searching for documents) or "1" (searching for users)
  */
  static Future<List<dynamic>> search(String query, String typeFlag) async {

    if(typeFlag == "0") {
      var res = searchDocument(query);
      return res;
    }
    else if(typeFlag == "1"){
      var res = searchUser(query);
      return res;
    }
    else{
      print("######## SEARCH: BAD FLAG INPUT");
    }
  }

  static Future<List<Document>> searchDocument(String query) async {
    final response =
    await http.get(
        _URL + _SEARCH_DOC_SERVER + "?searchString=" + query.toString(),
        headers: {'Authorization':_sessionToken}
    );

    if(response.statusCode == 200){
      var num = json.decode(response.body)["body"]["num"];
      List<dynamic> docs = json.decode(response.body)["body"]["docs"];
      List<Document> res = Document.parseJsonList(num, docs);
      return res;
    }
    else if(response.statusCode == 400){
      print("######### BAD INPUT PARAMENTER");
    }
    else if(response.statusCode == 500){
      print("######### SERVER INTERNAL ERROR");
    }

  }

  static Future<List<User>> searchUser(String query) async {
    final response =
    await http.get(
        _URL + _SEARCH_USER_SERVER + "?searchString=" + query.toString(),
        headers: {'Authorization':_sessionToken}
    );

    if(response.statusCode == 200){
      var num = json.decode(response.body)["body"]["num"];
      List<dynamic> users = json.decode(response.body)["body"]["users"];
      List<User> res = User.parseJsonList(num, users);
      return res;
    }
    else if(response.statusCode == 400){
      print("######### BAD INPUT PARAMENTER");
    }
    else if(response.statusCode == 500){
      print("######### SERVER INTERNAL ERROR");
    }

  }


                                /*########     LIKES  HANDLING     ########*/


  static Future addLike(String user, String docId) async{
    final response =
        await http.post(
          _URL + _LIKE_SERVER,
          body: {"username": user, "doc_id": docId});

    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  static Future retrieveLikes(String docId) async{
    final response =
        await http.get( _URL + _LIKE_SERVER + "/" + docId);

    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }
}


                                /*########     FAVOURITES  HANDLING     ########*/

