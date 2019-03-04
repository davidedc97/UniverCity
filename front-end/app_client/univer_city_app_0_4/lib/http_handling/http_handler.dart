import 'package:http/http.dart' as http;
import 'package:univer_city_app_0_4/elements/document.dart';
import 'package:univer_city_app_0_4/elements/user.dart';
import 'package:univer_city_app_0_4/elements/server_exception.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class HttpHandler {

  static const _URL = "https://ogv7kvalpf.execute-api.eu-west-1.amazonaws.com/dev";
  static const _DOCUMENT_SERVER = "/document";
  static const _SEARCH_SERVER = "/search";
  static const _USER_SERVER = "/user";
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
  static Future<int> userFormRegistration(user, name, surname, email, pw, faculty, university) async {
    final response =
      await http.post(
        _URL + _USER_SERVER,
        body: {"username": user, "name": name, "surname": surname, "email": email, "pass": pw, "faculty": faculty, "university":university});

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
  /*
  static Future<int> userFormRegistrationCognito(user, name, surname, email, pw, faculty, university) async {
    final response =
      await http.post(
        _URL + _USER_SERVER,
        body:{
          "DesiredDeliveryMediums": "EMAIL",
          "ForceAliasCreation": false,
          "MessageAction": "SUPPRESS",
          "UserAttributes": [
            {"Name": "name", "Value": name},
            {"Name": "surname", "Value": surname},
            {"Name": "email", "Value": email},
            {"Name": "faculty", "Value": faculty},
            {"Name": "university", "Value": university}
          ],
          "Username": user,
          "UserPoolId": _poolId,
        });


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
  */

  static Future testUser(user, pw, name, surname) async {


  }

  static Future testDocument(){

  }

  /*
    ** This function returns:
    **   1 if the user is in the Db and the password is correct
    **  -1 if no user is found or the password is invalid
    **  -2 if there's an internal error
    **  throws an exception otherwise
  */
  static Future<int> validateLogin(user, pw) async {
    final response =
      await http.post(
        _URL + _USER_SERVER,
        body: {"username": user, "pass": pw});

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

  static Future<User> getMyUserById(userId) async {
    final response =
    await http.get(_URL + _USER_SERVER + "/" + userId);
    if(response.statusCode == 200){
      return User.fromJson(json.decode(response.body));
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  static Future<User> getOtherUserById(userId) async {
    final response =
        await http.get(_URL + _USER_SERVER + "/" + userId);
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
    var request = new http.MultipartRequest("POST", uri);
    request.fields["title"] = title;
    request.fields["type"] = type;
    var file = await http.MultipartFile.fromPath('package', path);
    request.files.add(file);
    await request.send().then( (response) {
      ///
      /// Ho solo tirato fuori response
      ///
      res = response;
    });
    ///
    /// E fatto i controlli qui
    ///
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


  static Future<Uint8List> getDocumentById(docId) async{
    final response =
      await http.get(_URL + _DOCUMENT_SERVER + "?id=" + docId);

    if(response.statusCode == 200) {
      var j =  json.decode(response.body);
      String s = j['body'];
      return Uint8List.fromList(s.codeUnits);
      //return response.bodyBytes;
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  ///
  /// ERRORE
  /// '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'List<Map<String, dynamic>>
  ///
  static Future<List<Document>> searchDocuments(query) async {
    final response =
    await http.get(_URL + _SEARCH_SERVER + "?string=" + query);

    if(response.statusCode == 200){

      return Document.parseJsonList(json.decode(response.body));
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }
  ///
  /// TEST TIZIO
  ///
  /// Funzione che usa la classe DocumentList che mi salva soltanto una
  /// List<Document> che viene costruita dai metodi di Document
  /// usando un for sulla lista
  /// vedi documents.dart per il codice

  static Future<DocumentList> fetchDocuments(query) async {
    final response =
    await http.get(_URL + _SEARCH_SERVER + "?string=" + query);

    if(response.statusCode == 200){
      return DocumentList.fromJson(json.decode(response.body));
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }

  ///
  /// con questa funge dopo aver sistemato robette
  /**
  static Future<List<Document>> testSearchDocuments(query) async {
    debugPrint('query "$query"');
    await Future.delayed(Duration(milliseconds: 18));
    List<Document> l = [
      Document('test1', 'boh', '68c5e7d6-3c19-11e9-b210-d663bd873d93'),
      Document('Controlli automatici', 'boh','c31aec30-39ea-11e9-b210-d663bd873d94'),
      Document('Architetture dei calcolatori', 'boh','c31aeee2-39ea-11e9-b210-d663bd873d95'),
      Document('Algoritmi e strutture dati', 'boh','c31af04a-39ea-11e9-b210-d663bd873d96'),
      Document('Sistemi di calcolo', 'boh','c31af4f0-39ea-11e9-b210-d663bd873d97'),
      Document('Fisica', 'boh','c31af66c-39ea-11e9-b210-d663bd873d98'),
      Document('Analisi I', 'boh','c31af7b6-39ea-11e9-b210-d663bd873d99'),
      Document('Reti dei calcolatori', 'boh','c31af8f6-39ea-11e9-b210-d663bd873d83'),
      Document('Telecomunicazioni', 'boh','c31afa36-39ea-11e9-b210-d663bd873d84'),
      Document('Linguaggi e tecnologie web', 'boh','c31afb76-39ea-11e9-b210-d663bd873d85'),
    ];

    if(query != '')return l;
  }**/

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


  static Future addLike(user, docId) async{
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


  static Future retrieveLikes(docId) async{
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