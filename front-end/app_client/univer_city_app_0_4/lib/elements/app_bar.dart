import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

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
  ///
  /// Contiene titolo e uuid, i risultati della ricerta tramite titolo
  ///
  Map<String, String> _docs = {
  'Controlli automatici':'c31aec30-39ea-11e9-b210-d663bd873d93',
  'Architetture dei calcolatori':'c31aeee2-39ea-11e9-b210-d663bd873d93',
  'Algoritmi e strutture dati':'c31af04a-39ea-11e9-b210-d663bd873d93',
  'Sistemi di calcolo':'c31af4f0-39ea-11e9-b210-d663bd873d93',
  'Fisica':'c31af66c-39ea-11e9-b210-d663bd873d93',
  'Analisi I':'c31af7b6-39ea-11e9-b210-d663bd873d93',
  'Reti dei calcolatori':'c31af8f6-39ea-11e9-b210-d663bd873d93',
  'Telecomunicazioni':'c31afa36-39ea-11e9-b210-d663bd873d93',
  'Linguaggi e tecnologie web':'c31afb76-39ea-11e9-b210-d663bd873d93',
  };


  ///
  /// contiene il documento selezionato <titolo, uuid>
  ///
  String _name = 'No one';

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
              results: _docs.keys.map((String val) => new MaterialSearchResult<String>(
                icon: Icons.description,
                value: val,
                text: "$val",
              )).toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim()
                    .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) => Navigator.of(context).pop(value),
              onSubmit: (String value) => Navigator.of(context).pop(value),
            ),
          );
        }
    );
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      setState(() => _name = value as String);
    });
  }



  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          'UniverCity',
          style: TextStyle(
            fontFamily: 'Collegiate',
            fontSize: 32.0,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            debugPrint('is Searching true');
            _showMaterialSearch(context);
          },
        ),

      ],
    );
  }
}


