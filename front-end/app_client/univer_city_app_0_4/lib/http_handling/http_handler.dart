import 'package:http/http.dart' as http;
import 'package:univer_city_app_0_4/elements/document.dart';
import 'package:univer_city_app_0_4/elements/user.dart';
import 'package:univer_city_app_0_4/elements/server_exception.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';



class HttpHandler {
  static String _sessionToken;
  static const _URL = "https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev";
  static const _FAKE_LOG_URL = "https://v1uu1cu9ld.execute-api.eu-west-1.amazonaws.com/alpha";
  static const _DOCUMENT_SERVER = "/document";
  static const _SEARCH_SERVER = "/search";
  static const _LOGIN_SERVER = "/userLog";
  static const _REG_SERVER = "/userReg";
  static const _LIKE_SERVER = "/like";
  static const _MASHUP_SERVER = "/mashup";
  static const _poolId = "awsUserPoolId";


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
    final response =
      await http.post(
          _FAKE_LOG_URL+_LOGIN_SERVER,
        headers:{
          'Content-type' : 'application/json',
          'Accept': 'application/json',
        },
        body:json.encode({"username":user,"pass": pw})
            ); //TODO "flag": flag
    print(response.statusCode);
    print('BODY :' + response.body);
    //return 1;
    if(response.statusCode == 200) {
      _sessionToken = response.headers['token'];
      return 1;
    }
    else if(response.statusCode == 400 || response.statusCode == 403) {
      return -1;
    }
    else if(response.statusCode == 500) {
      return -2;
    }
    else {
      //throw ServerException.withCode(response.statusCode);
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
    ** This function returns: TODO sistema alertdialog form login o registrazione (xTiziano)
    **   1 if the document is succesfully uploaded
    **  -1 if there's a bad input parameter
    **  -2 if there's an internal error
    **  throws an exception otherwise
    **
  */

  static Future<int> uploadDocument(String title, String path) async {
    var res;
    String _t = title;
    var uri = Uri.parse(_URL + _DOCUMENT_SERVER);
    var request = new http.MultipartRequest('POST', uri);
    var file = await http.MultipartFile.fromPath('package', path);

    request.headers.addAll({'Authorization':_sessionToken,});
    request.fields.addAll({'title':_t.toString()});
    request.files.add(file);

    await request.send().then( (response) {
      res = response;
    });

    print(res.statusCode);

    if (res.statusCode == 200) {
      //debugPrint('up1');
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
      return -3;//throw ServerException.withCode(response.statusCode);
    }
  }


  static Future<Uint8List> getDocumentById( String docId) async{
    final response =
      await http.get(
          _URL + _DOCUMENT_SERVER + "?id=" + docId,
          headers: {'Authorization':_sessionToken ,'Content-type' : 'application/json', 'Accept': 'application/json'}
          );

    if(response.statusCode == 200) {
      return response.bodyBytes;
    }
    else{
      print(response.statusCode);
      //throw ServerException.withCode(response.statusCode);
    }
  }


  /*
    ** This function returns a list of documents/users fitting the query
    ** The value of typeFlag must be "0" (searching for documents) or "1" (searching for users)
  */

  static Future<List<dynamic>> search(String query, String typeFlag) async {
    final response =
      await http.get(
          _URL + _SEARCH_SERVER + "?searchString=" + query.toString() + "&flag=" + typeFlag.toString(),
          headers: {'Authorization':_sessionToken}
          );

    if(response.statusCode == 200){
      if(typeFlag == "0") {
        var num = json.decode(response.body)["body"]["num"];
        List<dynamic> docs = json.decode(response.body)["body"]["docs"];
        List<Document> res = Document.parseJsonList(num, docs);
        return res;
      }
      else if(typeFlag == "1"){
        var num = json.decode(response.body)["body"]["num"];
        List<dynamic> users = json.decode(response.body)["body"]["docs"];
        List<User> res = User.parseJsonList(num, users);
        return res;
      }
    }
    else{
      throw ServerException.withCode(response.statusCode);
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


  static Future<dynamic> mashup(List<String> pageIds) async {
    final response =
        await http.post(
          _URL + _MASHUP_SERVER,
          body:{"pages": json.encode(pageIds)});

    if(response.statusCode == 201){
      return;
    }
    else{
      throw ServerException.withCode(response.statusCode);
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