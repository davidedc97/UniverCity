import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/body_drawer/body_drawer.dart';

class HomeUniverCity extends StatefulWidget {
  final drawerEntry = [
    DrawerEntry('Homepage', Icons.home),
    DrawerEntry('Cronologia', Icons.history),
    DrawerEntry('Mashups', Icons.insert_drive_file),
    DrawerEntry('Feedback', Icons.feedback),
    DrawerEntry('Segnala bug', Icons.bug_report),
    DrawerEntry('Logout', Icons.exit_to_app)
  ];

  @override
  _HomeUniverCityState createState() => _HomeUniverCityState();
}

class _HomeUniverCityState extends State<HomeUniverCity> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return Cronologia();
      case 2:
        return Mashup();
      case 3:
        return Feed();
      case 4:
        return Bug();
      default:
        return Text('Errore switch Drawer outOfIndex ;) ');
    }
  }

  _onSelectItem(int index) {
    if (index != 5) {
      setState(() => _selectedDrawerIndex = index);
      Navigator.of(context).pop();
    } else {
      //TODO funzione di logout e poi v questo qua sotto per riportare alla schermata do login
      Navigator.pushNamedAndRemoveUntil(
          context, '/', (Route<dynamic> route) => false);
      //Navigator.popAndPushNamed(context, '/login');
    } //chiude il drawer
  }

  @override
  Widget build(BuildContext context) {
    ///
    ///Assemblo le entry nel drawer prendendo i valori in drawerEntry
    ///
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerEntry.length; i++) {
      var d = widget.drawerEntry[i];
      drawerOptions.add(
        ListTile(
          leading: (i == _selectedDrawerIndex)
              ? Icon(
                  d.icon,
                  size: 40,
                  color: Theme.of(context).accentColor,
                )
              : Icon(d.icon),
          title: (i == _selectedDrawerIndex)
              ? Text(
                  d.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                )
              : Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        ),
      );
    }

    ///
    ///
    /// Builder home page
    ///
    ///
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: drawerOptions),
        ),
        ///
        ///
        /// App bar 
        ///
        ///
        appBar: AppBar(
            bottom:(_selectedDrawerIndex == 2)? TabBar(
              tabs: [
                Tab(
                  text: 'Scegli',
                ),
                Tab(
                  text: 'Componi',
                ),
              ],
            ):null,
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
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  _showSearch(context);
                },
              ),
              IconButton(
                icon: Icon(
                    Icons.account_circle
                ),
                onPressed: (){
                  _showProfilo(context);
                },
              ),
            ]
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        floatingActionButton: (_selectedDrawerIndex == 0) ? HomeFab() : null,
      ),
    );
  }
///
///
/// Funzioni push ricerca e profilo
///
///
  _showSearch(context){
    showSearch(context: context, delegate: DocSearch());
  }
  _showProfilo(context){
    Navigator.of(context).pushNamed('/profilo');
  }
}
