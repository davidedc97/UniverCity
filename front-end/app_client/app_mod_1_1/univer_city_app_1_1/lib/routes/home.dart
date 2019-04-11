import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/body_drawer/body_drawer.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/filtri_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_search_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/mash_bloc_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeUniverCity extends StatefulWidget {
  @override
  _HomeUniverCityState createState() => _HomeUniverCityState();
}

class _HomeUniverCityState extends State<HomeUniverCity> {
  int _selectedDrawerIndex = 0;
  final GlobalKey<RefreshIndicatorState> _rIKPreferiti =
      new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _rIKMash =
      new GlobalKey<RefreshIndicatorState>();

  _getDrawerItemWidget(int index) {
    switch (index) {
      case 0:
        PreferitiBloc _bloc = PreferitiBlocProvider.of(context);
        return RefreshIndicator(
          key: _rIKPreferiti,
          child: Home(_bloc),
          onRefresh: () async {
            await _bloc.init();
            setState(() {});
          },
        );
      case 1:
        return Cronologia();
      case 2:
        MashupBloc _mBloc = MashupBlocProvider.of(context);
        return RefreshIndicator(
          key: _rIKMash,
          child: Mashup(_mBloc),
          onRefresh: () async {
            await _mBloc.init();
            setState(() {});
          },
        );
      default:
        return Text('Errore switch Drawer outOfIndex ;) ');
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    //chiude il drawer
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ThemeBloc tBloc = ThemeBlocProvider.of(context);
    tBloc.onScaffoldKeyChange(_scaffoldKey);

    ///
    ///
    /// Builder home page
    ///
    ///
    return Scaffold(
        key: _scaffoldKey,
        // TODO decommenta quando flutter andra in versione 1.3 !
        //extendBody: true,

        ///
        ///
        /// App bar
        ///
        ///
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
            elevation: 2,
            leading: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  SessionUser.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (Route<dynamic> route) => false);
                }),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Text(
                'UniverCity',
                style: TextStyle(
                  color: tBloc.state ? Color(0xFF262526) : Colors.white,
                  fontFamily: 'Collegiate',
                ),
              ),
            ),
            actions: (_selectedDrawerIndex == 4 || _selectedDrawerIndex == 3)
                ? null
                : <Widget>[
                    Switch(
                        value: tBloc.state,
                        onChanged: (_) {
                          tBloc.change();
                        }),
                    PopupMenuButton<String>(
                      onSelected: choiceAction,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text('Segnala un bug'),
                            value: 'bug',
                          ),
                        ];
                      },
                    )
                  ]),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        bottomNavigationBar: Container(
          child: BottomAppBar(
            // TODO decommenta quando flutter sara alla versione 1.3
            // shape: CircularNotchedRectangle(),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.history,
                        color: _selectedDrawerIndex == 1 ? accentColor : null,
                      ),
                      onPressed: () {
                        _onSelectItem(1);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () {
                        _showProfilo(context);
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        _showSearch(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.art_track,
                        color: _selectedDrawerIndex == 2 ? accentColor : null,
                      ),
                      onPressed: () {
                        _onSelectItem(2);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: (_selectedDrawerIndex == 0)
            ? HomeFab()
            : FloatingActionButton(
                backgroundColor: tBloc.fabColor,
                onPressed: () {
                  _onSelectItem(0);
                },
                child: Icon(Icons.home)));
  }

  ///
  ///
  /// Funzioni push ricerca e profilo
  ///
  ///
  _showSearch(context) {
    showSearch(
        context: context,
        delegate: DocSearch(CronologiaSearchBlocProvider.of(context),
            FiltriBlocProvider.of(context)));
  }

  _showProfilo(context) {
    Navigator.of(context).pushNamed('/profilo', arguments: <String, String>{
      'userName': SessionUser.user ?? 'sessionNotInit',
    });
  }

  choiceAction(String choice) {
    if (choice == 'bug') {
      launch('https://github.com/davidedc97/UniverCity/issues/new/');
    }
  }
}
