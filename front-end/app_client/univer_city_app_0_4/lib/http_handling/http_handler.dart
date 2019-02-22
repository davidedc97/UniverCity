import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:univer_city_app_0_4/elements/document.dart';


class Post {                 //classe di esempio presa da internet
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']);
  }
}

class HttpHandler {

  static const _URL = "http://www.porcaccioiltuodio.mam";

  Future<Post> fetchPost() async {
    final response =
    await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Post.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

                                /*########     USER  HANDLING     ########*/


  static Future sendFormRegistration(user, name, surname, email, pw, faculty, university) async {

    final response =
      await http.post(
        _URL + "/userData",
        body: {"user": user, "name": name, "surname": surname, "email": email, "pass": pw, "faculty": faculty, "university":university});
    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else{
      throw Exception("Error: "+ response.statusCode.toString());
    }
  }

  static Future validateLogin(user, pw, flag) async {

    final response =
      await http.post(
        _URL + "/userData",
        body: {"user": user, "pass": pw, "flag": flag});
    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else{
      throw Exception("Error: "+ response.statusCode.toString());
    }
  }


                                /*########     DOCUMENT  HANDLING     ########*/

  static Future uploadDocument(user, type, pages, tags) async {

    final response =
        await http.post(
          _URL + "/doc",
          body: {"user": user, "type": type, "pages": pages, "tags": tags});

    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else{
      throw Exception("Error: " + response.statusCode.toString());
    }
  }

  static Future downloadDocument(docId) async {
    final response =
        await http.get(_URL + "/doc" + ":" + docId);
    if(response.statusCode == 200){
      return Document.fromJson(json.decode(response.body));
    }
    else{
      throw Exception("Error: "+ response.statusCode.toString());
    }
  }

  static Future searchDocument() async {

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
      throw Exception("Error: " + response.statusCode.toString());
    }
  }

  static Future retrieveLikes() async{
    final response =
        await http.get( _URL + "/like");

    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else{
      throw Exception("Error :" + response.statusCode.toString());
    }
  }
}