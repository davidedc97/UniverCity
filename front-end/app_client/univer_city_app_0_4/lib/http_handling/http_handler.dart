import 'package:http/http.dart' as http;
import 'package:univer_city_app_0_4/elements/document.dart';
import 'package:univer_city_app_0_4/elements/user.dart';
import 'package:univer_city_app_0_4/elements/server_exception.dart';
import 'dart:convert';
import 'dart:typed_data';


class HttpHandler {

  static const _URL = "http://www.porcaccioiltuodio.mam";
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
  */
  static Future<int> uploadDocument(String title, String type, String path) async {
    var uri = Uri.parse(_URL + _DOCUMENT_SERVER);
    var request = new http.MultipartRequest("POST", uri);
    request.fields["title"] = title;
    request.fields["type"] = type;
    var file = await http.MultipartFile.fromPath('package', path);
    request.files.add(file);

    request.send().then( (response) {
      if (response.statusCode == 201) {
        return 1;
      }
      else if (response.statusCode == 400){
        return -1;
      }
      else if (response.statusCode == 500){
        return -2;
      }
      else{
        throw ServerException.withCode(response.statusCode);
      }
    });
  }


  static Future<Uint8List> getDocumentById(docId) async{
    final response =
      await http.get(_URL + _DOCUMENT_SERVER + "/" + docId);

    if(response.statusCode == 200) {
      return response.bodyBytes;
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }

  static Future<List<Document>> searchDocuments(query) async {
    final response =
        await http.get(_URL + _SEARCH_SERVER + "/" + "query");

    if(response.statusCode == 200){
      return Document.parseJsonList(json.decode(response.body));
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