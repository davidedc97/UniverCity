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
  List<Document> docs = <Document>[];
  List<User> users = <User>[];

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

  @override
  Widget buildResults(BuildContext context) {
    // show result based from selections
    bloc.addInCronologia(CronologiaSearchEntry(query));
    // todo get con i risultati
    updateSearch();
    String f;
    if(fBloc.filtriValue=='Appunto'){f='O';}
    if(fBloc.filtriValue=='Mashup'){f='M';}
    List<Document> risultatiList =[];
    if(docs != null){
      if(docs.isNotEmpty){
        risultatiList = docs
            .where((p) => p.title.toLowerCase().contains(query.toLowerCase())).where((p)=>p.type == f)
            .toList();
      }
    }
    List<User> risultatiUtenti =[];
    if(users != null){
      if(users.isNotEmpty){
        risultatiUtenti = users.where((u)=>u.user.toLowerCase().contains(query.toLowerCase())).toList();
      }
    }
    List<String> crono = bloc.cronologiaValue.map((e) => e.query).toList();
    // show when search for anythings

    int size;
    if(query.isEmpty){size = crono.length+1;}
    if(query.isNotEmpty && fBloc.filtriValue=='Utente'){
      size =  risultatiUtenti.length+1;
    }
    if(query.isNotEmpty && fBloc.filtriValue!='Utente' ){
      size =  risultatiList.length+1;
    }
    return StreamBuilder(
      stream: fBloc.filtri,
      builder: (context, snapshot){

        return ListView.builder(
          itemBuilder: (context, i){
            if (i == 0){return Container(child: Filtri());}
            if (query.isEmpty){
              ///
              /// Mostra la cronologia
              /// perche il campo query è vuoto
              ///
              return ListTile(
                leading: Icon(Icons.history),
                title: Text(crono[i-1]),
                onTap: () {
                  query = crono[i-1];
                },
              );
            }
            else{
              ///
              /// mostra i suggerimenti in base alla query
              ///
              if (fBloc.filtriValue == 'Utente') {
                return ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(risultatiUtenti[i-1].user),
                  onTap: () {Navigator.of(context).pushNamed('/profilo',arguments: <String, String>{
                    'userName': risultatiUtenti[i-1].user,});},
                );
              }else{
                return ListTile(
                  leading: Icon(risultatiList[i-1].type == 'O'
                      ? Icons.description
                      : Icons.art_track),
                  title: Text(risultatiList[i-1].title),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => buildDocDialog(
                            context,
                            risultatiList[i - 1].title,
                            risultatiList[i - 1].creator,
                            risultatiList[i - 1].id));
                  },
                );
              }
            }
          },
          itemCount: size,
        );
      },
    );
  }

  Timer _searchTimer;

  cancelSearch() {
    if (_searchTimer != null && _searchTimer.isActive) {
      /// rimuove il vecchio timer.
      _searchTimer.cancel();
      _searchTimer = null;
    }
  }

  updateSearch() async{
    cancelSearch();

    /// Un [Timer] è usato per evitare richieste inutili
    _searchTimer = Timer(
        Duration(
            milliseconds: query.isEmpty ? 0 : 350,
            hours: query.isEmpty ? 1 : 0), () {
      /// TODO qui funzione fetch per ricerca
      if(fBloc.filtriValue=='Utente'){
        HttpHandler.search(query, '1').then((l){users = l;});
      }
      if(fBloc.filtriValue!='Utente'){
        HttpHandler.search(query, '0').then((l){docs = l;});
      }
      debugPrint('cerca');
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    updateSearch();
    String f;
    if(fBloc.filtriValue=='Appunto'){f='O';}
    if(fBloc.filtriValue=='Mashup'){f='M';}
    List<Document> risultatiList = docs
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase())).where((p)=>p.type == f)
        .toList();
    List<User> risultatiUtenti = users.where((u)=>u.user.toLowerCase().contains(query.toLowerCase())).toList();
    List<String> crono = bloc.cronologiaValue.map((e) => e.query).toList();
    // show when search for anythings

    int size;
    if(query.isEmpty){size = crono.length+1;}
    if(query.isNotEmpty && fBloc.filtriValue=='Utente'){size =  risultatiUtenti.length+1;}
    if(query.isNotEmpty && fBloc.filtriValue!='Utente'){size =  risultatiList.length+1;}
    return StreamBuilder(
      stream: fBloc.filtri,
      builder: (context, snapshot){

        return ListView.builder(
          itemBuilder: (context, i){
            if (i == 0){return Container(child: Filtri());}
            if (query.isEmpty){
              ///
              /// Mostra la cronologia
              /// perche il campo query è vuoto
              ///
              return ListTile(
                leading: Icon(Icons.history),
                title: Text(crono[i-1]),
                onTap: () {
                  query = crono[i-1];
                },
              );
            }
            else{
              ///
              /// mostra i suggerimenti in base alla query
              ///
              if (fBloc.filtriValue == 'Utente') {
                return ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(risultatiUtenti[i-1].user),
                  onTap: () {Navigator.of(context).pushNamed('/profilo',arguments: <String, String>{
                  'userName': risultatiUtenti[i-1].user,});},
                );
              }else{
                return ListTile(
                  leading: Icon(risultatiList[i-1].type == 'O'
                      ? Icons.description
                      : Icons.art_track),
                  title: Text(risultatiList[i-1].title),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => buildDocDialog(
                            context,
                            risultatiList[i - 1].title,
                            risultatiList[i - 1].creator,
                            risultatiList[i - 1].id));
                  },
                );
              }
            }
          },
          itemCount: size,
        );
      },
    );
  }
}
