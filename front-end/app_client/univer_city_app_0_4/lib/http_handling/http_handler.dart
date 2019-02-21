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
  static final URL = "http://www.porcaccioiltuodio.mam";
  static final client = new http.Client();

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


  static Future send_registration(nome, email, password, facolta) async {

    final response =
      await http.post(
        URL + "/userData",
        body: {"nome": nome, "email": email, "password": password, "facolta": facolta});
    if(response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    }
    else{
      throw Exception("Error: "+ response.statusCode.toString());
    }
  }

  static Future validate_login(email, password, flag) async {

    final response =
      await http.post(
        URL + "/userData",
        body: {"email": email, "password": password, "flag": flag});
    if(response.statusCode == 200) {
      return json.decode(response.body);
    }
    else{
      throw Exception("Error: "+ response.statusCode.toString());
    }
  }


                                /*########     DOCUMENT  HANDLING     ########*/

  static Future upload_document(document /*e altri argomenti tipo i tag ecc*/) async {

  }

  static Future download_document() async {

  }

  static Future search_document() async {

  }

  static Future like_document() async{

  }
}