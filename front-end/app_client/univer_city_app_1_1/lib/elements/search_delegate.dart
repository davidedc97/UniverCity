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
  Future<List<Result>> l;

  Timer _searchTimer;

  cancelSearch() {
    if (_searchTimer != null && _searchTimer.isActive) {
      /// rimuove il vecchio timer.
      _searchTimer.cancel();
      _searchTimer = null;
    }
  }

  updateSearch() async {
    cancelSearch();

    /// Un [Timer] è usato per evitare richieste inutili
    _searchTimer = Timer(
        Duration(
            milliseconds: query.isEmpty ? 0 : 350,
            hours: query.isEmpty ? 1 : 0), () {
      debugPrint('cerca');

      /// TODO qui funzione fetch per ricerca
      if (fBloc.filtriValue == 1) {
        l = HttpHandler.search(query, '1');
      }
      if (fBloc.filtriValue != 1) {
        l = HttpHandler.search(query, '0');
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


  int size = 0;

  _showResults(context, int f) {
    fBloc.filtri.listen((_) {
      print('data on 112');
    });
    return StreamBuilder(
        stream: fBloc.filtri,
        builder: (context, snapshot) {
          updateSearch();
          List<String> crono =
              bloc.cronologiaValue.map((e) => e.query).toList() ?? [];
          if (query.isEmpty) {
            size = crono?.length ?? 0;
          }else{
            size = 2;
          }
          return ListView.builder(
            itemBuilder: (context, i) {
              if (i == 0 && f == 1) {
                return Container(
                  child: SizedBox(
                    height: 50,
                    child: Filtri(),
                  ),
                );
              }
              if (query.isEmpty) {
                /// mostro la cronologia
                return ListTile(
                  leading: Icon(Icons.history),
                  title: Text(crono[i - f]),
                  onTap: () {
                    query = crono[i - 1];
                  },
                );
              }
              return FutureBuilder(
                future: l,
                builder: (context, AsyncSnapshot<List<Result>> snapshot){
                  if(!snapshot.hasData){
                    return ListTile(leading: CircularProgressIndicator(),title: Text('Stiamo cercando...'));
                  }
                  return ListTile(leading: Icon(Icons.art_track),title: Text('Trovato'));
                },
              );
            },
            itemCount: size+f,
          );
        });
  }
}
