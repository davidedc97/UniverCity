import 'package:http/http.dart' as http;
import 'dart:convert';


class Post {
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
  static final _URL = "http://www.porcaccioiltuodio.mam";
  static final _client = new http.Client();

  static Future<Post> fetchPost() async {   //funzione di esempio presa da internet
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

                                /*########     USER  HANDLING     ########*/


  static Future send_form_registration(user, name, surname, email, pw, faculty) async {

    final response =
      await http.post(
        _URL + "/userData",
        body: {"user": user, "name": name, "surname": surname, "email": email, "pass": pw, "faculty": faculty});
    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else{
      throw Exception("Error: "+ response.statusCode.toString());
    }
  }

  static Future validate_login(user, pw, flag) async {

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

  static Future upload_document(user, type, pages, tags) async {

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

  static Future download_document() async {

  }

  static Future search_document() async {

  }

  static Future add_like(user) async{
    final response =
        await http.post(
          _URL + "/like",
          body: {"user": user});

    if(response.statusCode == 200) {
      return json.decode(response.body);
      // non so cosa tornare, se richiamare qualcosa per refreshare il numero di like visualizzati in pagina
    }
    else{
      throw Exception("Error: " + response.statusCode.toString());
    }
  }

  static Future retrieve_likes() async{
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