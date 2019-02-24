import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:univer_city_app_0_4/elements/document.dart';
import 'package:univer_city_app_0_4/elements/user.dart';
import 'package:univer_city_app_0_4/elements/server_exception.dart';

class HttpHandler {

  static const _URL = "http://www.porcaccioiltuodio.mam";


                                /*########     USER  HANDLING     ########*/


  static Future sendFormRegistration(user, name, surname, email, pw, faculty, university) async {
    final response =
      await http.post(
        _URL + "/userData",
        body: {"user": user, "name": name, "surname": surname, "email": email, "pass": pw, "faculty": faculty, "university":university});
    if(response.statusCode == 200) {
      return json.decode(response.body);  // TODO da vedere cosa mi tornano
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  static Future validateLogin(user, pw, flag) async {
    final response =
      await http.post(
        _URL + "/userData",
        body: {"user": user, "pass": pw, "flag": flag});
    if(response.statusCode == 200) {
      return json.decode(response.body);  //TODO check: dovrebbero tornare un booleano
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }

  static Future<User> getUserById(userId) async {
    final response =
        await http.get(_URL + "/userData" + "/" + userId);
    if(response.statusCode == 200){
      return User.fromJson(json.decode(response.body));
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }

                                /*########     DOCUMENT  HANDLING     ########*/


  static Future uploadDocument(user, type, pages, tags) async {
    final response =
        await http.post(
          _URL + "/doc",
          body: {"user": user, "type": type, "pages": pages, "tags": tags});

    if(response.statusCode == 200) {
      return json.decode(response.body);  //TODO da vedere cosa mi tornano
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  static Future<Document> downloadDocument(docId) async {
    final response =
        await http.get(_URL + "/doc" + "/" + docId);

    if(response.statusCode == 200){
      return Document.fromJson(json.decode(response.body));
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  static Future searchDocument(title) async {
    final response =
        await http.post(
          _URL + "/doc",
          body: {"title": title});

    if(response.statusCode == 200){
      return json.decode(response.body); //TODO da vedere cosa mi ritornano
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


                                /*########     LIKES  HANDLING     ########*/


  static Future addLike(user, docId) async{
    final response =
        await http.post(
          _URL + "/like",
          body: {"user": user, "doc_id": docId});

    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }


  static Future retrieveLikes() async{
    final response =
        await http.get( _URL + "/like");

    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else{
      throw ServerException.withCode(response.statusCode);
    }
  }
}