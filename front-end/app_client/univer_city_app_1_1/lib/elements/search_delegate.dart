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
  List<Result> res = <Result>[];

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
        HttpHandler.search(query, '1').then((l){res = l;});
      }
      if(fBloc.filtriValue!='Utente'){
        HttpHandler.search(query, '0').then((l){res = l;});
      }
      debugPrint('cerca');
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

  _showResults(context, int f){
    updateSearch();
    int size;
    List<Result> resF = res?.where((r)=>r.title.toLowerCase()?.contains(query.toLowerCase()))?.toList();
    List<String> crono = bloc.cronologiaValue.map((e) => e.query).toList()??[];
    if(fBloc.filtriValue=='Appunto'){
      resF = resF?.where((r)=>r.docInfo.type=='O')?.toList();
    }
    if(fBloc.filtriValue=='Mashup'){
      resF = resF?.where((r)=>r.docInfo.type=='M')?.toList();
    }
    if(query.isEmpty){
      size = crono?.length??0;
    }else{
      size = resF?.length??0;
    }

    return StreamBuilder(
      stream: fBloc.filtri,
      builder: (context, snapshot){
        return ListView.builder(
            itemBuilder: (context, i){
              if(i==0 && f==1) return Container(child: Filtri());
              if(query.isEmpty){
                /// mostro la cronologia
                return ListTile(
                  leading: Icon(Icons.history),
                  title: Text(crono[i-f]),
                  onTap: () {
                    query = crono[i-1];
                  },
                );
              }// chiusura query empty (cornologia)
              if(fBloc.filtriValue=='Utente'){
                return ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(resF[i-f].title),
                  onTap: (){Navigator.of(context).pushNamed('/profilo',arguments: <String, String>{
                    'userName': resF[i-f].title,});},
                );
              }
              return ListTile(
                leading: Icon(resF[i-f].docInfo.type=='O'?Icons.description:Icons.art_track),
                title: Text(resF[i-f].title),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) => buildDocDialog(
                          context,
                          resF[i-f].title,
                          resF[i-f].docInfo.creator,
                          resF[i-f].docInfo.uuid));
                },
              );
            },
          itemCount: size+f,
        );
      },
    );
  }
}



