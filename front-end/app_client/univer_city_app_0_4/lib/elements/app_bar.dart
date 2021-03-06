import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:univer_city_app_0_4/elements/pre_viewer.dart';
import 'package:univer_city_app_0_4/http_handling/http_handler.dart';
import 'package:univer_city_app_0_4/elements/document.dart';
import 'dart:async';
//############################################################################## MainAppBar

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  ///Serve per specificare di che altezza deve essere l'app bar
  ///Perche deve avere una preferred size
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {

  Future<Map<String, String>> _fetchMapSearch(criteria) async{
    List<Document> l = [Document('','','','')];
    Map<String, String> m = {};
    l = await HttpHandler.search(criteria, "0");  //TODO gestire il flag del tipo di ricerca

    for(Document e in l){
        m.putIfAbsent(e.uuid, ()=>e.title);
    }

    print(m);

    return m;
  }



  ///
  /// Contiene titolo e uuid, i risultati della ricerta tramite titolo
  ///
  Map<String, String> _docs = {
    'Controlli automatici': 'c31aec30-39ea-11e9-b210-d663bd873d93',
    'Architetture dei calcolatori': 'c31aeee2-39ea-11e9-b210-d663bd873d93',
    'Algoritmi e strutture dati': 'c31af04a-39ea-11e9-b210-d663bd873d93',
    'Sistemi di calcolo': 'c31af4f0-39ea-11e9-b210-d663bd873d93',
    'Fisica': 'c31af66c-39ea-11e9-b210-d663bd873d93',
    'Analisi I': 'c31af7b6-39ea-11e9-b210-d663bd873d93',
    'Reti dei calcolatori': 'c31af8f6-39ea-11e9-b210-d663bd873d93',
    'Telecomunicazioni': 'c31afa36-39ea-11e9-b210-d663bd873d93',
    'Linguaggi e tecnologie web': 'c31afb76-39ea-11e9-b210-d663bd873d93',
  };
  Map<String, String> m = {'':''};


  _buildMaterialSearchPage(BuildContext context) {

    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: '/search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Search',

              ///
              /// Indica come i risultai devono essere costruiti
              /// sotto in campo search
              ///
              ///

              getResults: (criteria)async{
                  m = await _fetchMapSearch(criteria);
                  return m.keys.map((String val)=>MaterialSearchResult<String>(
                    icon: Icons.description,
                    value: val,
                    text: m[val],
                  )).toList();
              },/**
              results: _docs.keys
                  .map((String val) => new MaterialSearchResult<String>(
                        icon: (val=='')?null:Icons.description,
                        value: val,
                        text: "$val",
                      ))
                  .toList(),
              filter: (dynamic value, String criteria) {
                ///
                /// - [criteria] contiene la stringa inserita nel campo search
                ///    e viene aggiornata ogni carattere inserito
                ///    quindi probabilmente qui faremo la richiesta dei documenti
                ///    <title, uuid> da inserire in _docs ( Map<String, String> )
                ///

                debugPrint(criteria);
                return value.toLowerCase().trim().contains(
                    new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },**/

              ///
              /// La funzione passata in onSelect viene richiamata quando viene
              /// selezionata una entry tra i risultati
              ///
              onSelect: (dynamic value){
                print(value);
                print(m[value]);
                showDialog(
                    context: context,
                    builder: (context) =>
                        buildDocDialog(context, m[value], value));
              }

              ///
              /// onSubmit: (String value) => debugPrint('value'),
              /// la funzione passata a onSubmit viene eseguita quando si
              /// da invio dopo aver scritto nel campo search e value contiene
              /// il valore inserito nel campo
              ///
            ),
          );
        });
  }

  ///
  /// metodo che pusha nello stack delle visuali la schermata di ricerca
  ///
  _showMaterialSearch(BuildContext context) {
    Navigator.of(context).push(_buildMaterialSearchPage(context));
  }

  ///
  /// AppBar del MainScaffold
  ///
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 2,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            'UniverCity',
            style: TextStyle(
              color: Color(0xFF262526),
              fontFamily: 'Collegiate',
              fontSize: 32.0,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,),
            onPressed: () {
              //debugPrint('is Searching true');
              _showMaterialSearch(context);
            },
          )
        ]);
  }
}

