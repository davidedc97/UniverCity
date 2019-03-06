import 'package:http/http.dart' as http;
import 'package:univer_city_app_0_4/elements/document.dart';
import 'package:univer_city_app_0_4/elements/user.dart';
import 'package:univer_city_app_0_4/elements/server_exception.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';



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
    **  -1 if the user is already in the Db
    **  -2 if there's an internal error
    **  throws an exception otherwise
  */
  static Future<int> userFormRegistration(String user,String name,String surname,String email,String pw,String faculty,String university) async {
    final response =
      await http.post(
        _FAKE_LOG_URL + _REG_SERVER,
        body: {"username": user, "name": name, "surname": surname, "email": email, "pass": pw, "faculty": faculty, "university":university});

    print(response.statusCode);

    if(response.statusCode == 200) {
      return 1;
    }
    else if(response.statusCode == 400) {
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
    **   1 if the user is correctly added to the Db
    **  -1 if there's bad input parameter, invalid user or password, user isn't authorized and many other problems
    **  -2 if there's an internal error
    **  throws an exception otherwise
  */


  static Future testUser(String user,String pw,String name,String surname) async {

  }

  static Future testDocument(){

  }

  /*
    ** This function returns:
    **   1 if the user is in the Db and the password is correct
    **  -1 if no user is found or the password is invalid
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
            ); //"flag": flag
    print(response.statusCode);
    print(response.headers);
    print('body '+response.body);
    //return 1;
    if(response.statusCode == 200) {
      print(response.headers['token']);
      _sessionToken = response.headers['token'];
      return 1;
    }
    else if(response.statusCode == 400) {
      return -1;
    }
    else if(response.statusCode == 500) {
      return -2;
    }
    else {
      print(response.statusCode);
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
    ** Questa è quella che ho usato per testarla
    ** static Future<int> testF() async{
    ** return Future.delayed(Duration(seconds: 5), ()=>1);
  }
  */



  static Future<int> uploadDocument(String title, String type, String path) async {
    var res;
    var uri = Uri.parse(_URL + _DOCUMENT_SERVER);
    var request = new http.MultipartRequest('POST', uri);
    request.headers.addAll({'Authorization':_sessionToken});
    request.fields["title"] = title;
    request.fields["type"] = type;
    var file = await http.MultipartFile.fromPath('package', path);
    request.files.add(file);

    await request.send().then( (response) {
      res = response;
    });

    if (res.statusCode == 201) {
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
      await http.get(_URL + _DOCUMENT_SERVER + "?id=" + docId, headers: {'Authorization':_sessionToken});

    if(response.statusCode == 200) {
      return response.bodyBytes;
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  ///
  /// ERRORE
  /// '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'List<Map<String, dynamic>>
  ///
  static Future<List<Document>> searchDocuments(String query) async {
    final response =
      await http.get(_URL + _SEARCH_SERVER + "?string=" + query, headers: {'Authorization':_sessionToken});

    if(response.statusCode == 200){
      var num = json.decode(response.body)["body"]["num"];
      List<dynamic> docs = json.decode(response.body)["body"]["docs"];
      List<Document> res = Document.parseJsonList(num, docs);
      return res;
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  /* TODO: devo capire come cazzo si fa
  static Future<Document> downloadDocument(docId) async {
    final response =
        await http.get(_URL + _DOCUMENT_SERVER + "/" + docId);

    if(response.statusCode == 200){
      return Document.fromJson(json.decode(response.body));
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }
  */

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
          body: {"user": user, "doc_id": docId});

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