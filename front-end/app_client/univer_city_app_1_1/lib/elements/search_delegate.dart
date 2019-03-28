import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/elements/user.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_search_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/filtri_bloc_provider.dart';
import 'dart:async';

class DocSearch extends SearchDelegate<Document> {
  final CronologiaSearchBloc bloc;
  final FiltriBloc fBloc;
  DocSearch(this.bloc, this.fBloc);
  final docTest = [
    Document('Telecomunicazioni', 'Cuomo',
        '550e8400-e29b-41d4-a716-446655440000', 'O'),
    Document('Architetture dei calcolatori', 'Ciciani',
        '550e8400-e29b-41d4-a716-446655440001', 'M'),
    Document('Reti dei calcolatori', 'Vitaletti',
        '550e8400-e29b-41d4-a716-446655440002', 'O'),
    Document('Sistemi di calcolo I', 'Demetrescu',
        '550e8400-e29b-41d4-a716-446655440003', 'O'),
    Document('Sistemi di calcolo II', 'Demetrescu',
        '550e8400-e29b-41d4-a716-446655440004', 'O'),
    Document('Teoria dei ststemi', 'Catardi',
        '550e8400-e29b-41d4-a716-446655440005', 'O'),
    Document('Fondamenti di automatica', 'Marchetti',
        '550e8400-e29b-41d4-a716-446655440006', 'O'),
    Document(
        'Economia', 'Nastasi', '550e8400-e29b-41d4-a716-446655440007', 'O'),
    Document('Controlli automatici', 'Nardi',
        '550e8400-e29b-41d4-a716-446655440008', 'O'),
    Document('EoA', 'Nardi', '550e8400-e29b-41d4-a716-446655440009', 'O'),
    Document(
        'Analisi I', 'Camilli', '550e8400-e29b-41d4-a716-446655440010', 'O'),
    Document('Analisi II', 'Camilli II', '550e8400-e29b-41d4-a716-446655440011',
        'O'),
    Document('Fisica', 'Sibilia', '550e8400-e29b-41d4-a716-446655440012', 'O'),
    Document('Probabilità e statistica', 'Toaldo',
        '550e8400-e29b-41d4-a716-446655440013', 'O'),
    Document('Sicurezza Informatica', 'Franco',
        '550e8400-e29b-41d4-a716-446655440014', 'O'),
    Document('Fodamenti di informatica', 'Shaerf',
        '550e8400-e29b-41d4-a716-446655440015', 'O'),
    Document('Algoritmi e strutture dati', 'D\'amore',
        '550e8400-e29b-41d4-a716-446655440016', 'O'),
    Document('Proggettazione software', 'de giacomo',
        '550e8400-e29b-41d4-a716-446655440017', 'O'),
  ];
  
  final List<User> userTest = <User>[
    User('Tiziano', '', '', '', '', ''),
    User('Davide', '', '', '', '', ''),
    User('Lucian', '', '', '', '', ''),
    User('Michele', '', '', '', '', ''),
    User('Riccardo', '', '', '', '', ''),
    User('Marco', '', '', '', '', ''),
    User('Matteo', '', '', '', '', ''),
    User('Damiano', '', '', '', '', ''),
  ];

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
    return Container();
  }

  Timer _searchTimer;

  cancelSearch() {
    if (_searchTimer != null && _searchTimer.isActive) {
      /// rimuove il vecchio timer.
      _searchTimer.cancel();
      _searchTimer = null;
    }
  }

  updateSearch() {
    cancelSearch();

    /// Un [Timer] è usato per evitare richieste inutili
    _searchTimer = Timer(
        Duration(
            milliseconds: query.isEmpty ? 0 : 350,
            hours: query.isEmpty ? 1 : 0), () {
      /// TODO qui funzione fetch per ricerca
      debugPrint('cerca');
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    updateSearch();
    List<Document> risultatiList = docTest
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    List<User> risultatiUtenti = userTest.where((u)=>u.user.toLowerCase().contains(query.toLowerCase())).toList();
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
                  onTap: () {},
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
                            risultatiList[i - 1].uuid));
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
