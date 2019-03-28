import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';
import 'package:univer_city_app_1_1/elements/document.dart';

class ShowNoteClp extends StatefulWidget {

  final List<Document> docs;
  final String title;
  ShowNoteClp(this.title,this.docs);

  @override
  _ShowNoteClpState createState() => _ShowNoteClpState();
}

class _ShowNoteClpState extends State<ShowNoteClp> {

  bool _isExpanded = false;
  _toggle(){setState(() {
    _isExpanded = !_isExpanded;
  });}
  @override
  Widget build(BuildContext context) {
    final ThemeBloc tBloc = ThemeBlocProvider.of(context);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      tBloc.firstColorGradient,
                      Theme.of(context).accentColor,
                    ])),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, left: 16.0, bottom: 8.0),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ] +
                widget.docs.sublist(0,_isExpanded?null:5)
                    .map((doc) => ListTile(
                  leading: Icon(
                    doc.type=='O'?Icons.description:Icons.art_track,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(doc.title),
                ))
                    .toList()+[FlatButton.icon(onPressed: _toggle, icon: Icon(_isExpanded?Icons.remove_circle_outline:Icons.add_circle_outline, size: 18,), label:Text(_isExpanded?'mostra di meno':'mostra di più'))],
          )),
    );
  }
}


