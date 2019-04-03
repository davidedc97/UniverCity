import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/elements/user.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_search_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/filtri_bloc_provider.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'dart:async';

class DocSearch extends SearchDelegate<Document> {
  final CronologiaSearchBloc bloc;
  final FiltriBloc fBloc;
  DocSearch(this.bloc, this.fBloc);

  Timer _searchTimer;

  cancelSearch() {
    if (_searchTimer != null && _searchTimer.isActive) {
      /// rimuove il vecchio timer.
      _searchTimer.cancel();
      _searchTimer = null;
    }
  }

  int size = 0;

  updateSearch() async {
    cancelSearch();

    /// Un [Timer] è usato per evitare richieste inutili
    _searchTimer = Timer(
        Duration(
            milliseconds: query.isEmpty ? 0 : 350,
            hours: query.isEmpty ? 1 : 0), () {
      /// TODO qui funzione fetch per ricerca
      if (fBloc.filtriValue == 0) {
        debugPrint('cerca');
        fBloc.searchUser(query);
      }
      if (fBloc.filtriValue != 0) {
        debugPrint('cerca');
        fBloc.searchDoc(query, fBloc.filtriValue);
      }
    });
  }

  ///
  ///Indica quale tema deve usare il search delegate
  ///
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }

  ///
  /// Si occupa di creare le actions che verranno mostrare affianco
  /// alla search bar, per ora c'è solo la X per cancelare il campo [query]
  ///
  @override
  List<Widget> buildActions(BuildContext context) {
    //  action for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  ///
  /// Si occupa di creare l'icona che apparira alla sinistra della search
  /// bar, qui è l'icona per tornare indietro
  ///
  @override
  Widget buildLeading(BuildContext context) {
    //  leading icon
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  ///
  /// È la funzione che si occupa di creare i risultati della ricerca
  ///
  @override
  Widget buildResults(BuildContext context) {
    // show result based from selections
    bloc.addInCronologia(CronologiaSearchEntry(query));
    return _showResults(context, 0);
  }

  ///
  /// È la funzione che si occupa di creare i suggerimenti della ricerca
  ///
  @override
  Widget buildSuggestions(BuildContext context) {
    return _showResults(context, 1);
  }

  _showResults(context, int f) {
    return StreamBuilder(
      stream: fBloc.filtri,
      builder: (context, snapshot) {
        print('build');
        updateSearch();
        List<String> crono =
            bloc.cronologiaValue.map((e) => e.query).toList() ?? [];
        return Column(
          children: <Widget>[
            f == 1
                ? Container(
                    child: SizedBox(
                      height: 50,
                      child: Filtri(),
                    ),
                  )
                : Container(),
            Container(
              child: Expanded(
                  child: StreamBuilder(
                stream: fBloc.result,
                builder: (context, AsyncSnapshot<List<Result>> snapshot) {
                  debugPrint('builder future');
                  if (query.isEmpty) {
                    return ListView.builder(
                        itemCount: crono.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Icon(Icons.history),
                            title: Text(crono[i]),
                            onTap: () {
                              query = crono[i];
                            },
                          );
                        });
                  }
                  if (!snapshot.hasData) {
                    return ListTile(
                      leading: SizedBox(height: 18,width: 18, child: CircularProgressIndicator(strokeWidth: 1)),
                      title: Text('Stiamo cercando...'),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                          return ListTile(
                            leading: Icon(snapshot.data[i].docInfo == null
                                ? Icons.account_circle
                                : (snapshot.data[i].docInfo.type == true)
                                ? Icons.art_track
                                : Icons.description),
                            title: Text(snapshot.data[i].title),
                            onTap: () {
                              if (snapshot.data[i].docInfo == null) {
                                Navigator.of(context).pushNamed('/profilo',
                                    arguments: <String, String>{
                                      'userName': snapshot.data[i].title
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => buildDocDialog(
                                        context,
                                        snapshot.data[i]?.title,
                                        snapshot.data[i]?.docInfo?.creator,
                                        snapshot.data[i]?.docInfo?.uuid));
                              }
                            },
                          );
                      });
                },
              )),
            )
          ],
        );
      },
    );
  }
}
