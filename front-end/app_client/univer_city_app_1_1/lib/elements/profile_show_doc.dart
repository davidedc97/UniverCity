import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';
import 'package:univer_city_app_1_1/elements/document.dart';

class ShowDoc extends StatelessWidget {
  final List<Document> docTest;
  ShowDoc(this.docTest);
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
                    'Appunti caricati',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ] +
                docTest
                    .map((doc) => ListTile(
                  leading: Icon(
                    Icons.description,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(doc.title),
                ))
                    .toList(),
          )),
    );
  }
}

class ShowMashups extends StatelessWidget {
  final List<Document> mashTest ;
  ShowMashups(this.mashTest);
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
                    'Mashup creati',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ] +
                mashTest
                    .map((doc) => ListTile(
                  leading: Icon(
                    Icons.art_track,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(doc.title),
                ))
                    .toList(),
          )),
    );
  }
}

