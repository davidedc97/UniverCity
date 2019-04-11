import 'package:univer_city_app_1_1/elements/user.dart';
import 'package:univer_city_app_1_1/elements/document.dart';

class Result{
  final String title;
  final Document docInfo;
  final User userInfo;
  const Result(this.title, {this.docInfo, this.userInfo});
  dynamic get info => docInfo==null?userInfo:docInfo;
}