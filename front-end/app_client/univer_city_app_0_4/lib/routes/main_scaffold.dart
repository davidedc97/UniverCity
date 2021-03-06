import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/app_bar.dart';
import 'package:univer_city_app_0_4/elements/fab_home.dart';
import 'package:univer_city_app_0_4/bodies_drawer/history.dart';
import 'package:univer_city_app_0_4/bodies_drawer/home.dart';
import 'package:univer_city_app_0_4/bodies_drawer/mashups.dart';
import 'package:univer_city_app_0_4/bodies_drawer/report_bug.dart';
import 'package:univer_city_app_0_4/bodies_drawer/send_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerEntry {
  String title;
  IconData icon;
  DrawerEntry(this.title, this.icon);
}

class MainScaffold extends StatefulWidget {
//############################################################################## drawer entry
  final drawerEntry = [
    DrawerEntry('Homepage', Icons.home),
    DrawerEntry('Cronologia', Icons.history),
    DrawerEntry('Mashups', Icons.insert_drive_file),
    DrawerEntry('Feedback', Icons.feedback),
    DrawerEntry('Segnala bug', Icons.bug_report),
    DrawerEntry('Logout', Icons.exit_to_app)
  ];

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  //############################################################################ STATO
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int index) {
    switch (index) {
      case 0:
        return MyHome();
      case 1:
        return MyHistory();
      case 2:
        return Mashups();
      case 3:
        return SendFeedback();
      case 4:
        launch('https://github.com/davidedc97/UniverCity/issues/new/',
            forceSafariVC: false);
        return ReportBug();
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
      drawerOptions.add(Container(
        decoration: BoxDecoration(
          color: (i == _selectedDrawerIndex)
              ///
              /// Sfondo drawer quando selezionato
              ///
              ? null //Theme.of(context).accentColor
              : null,
        ),
        child: ListTile(
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
      ));
    }

    //########################################################################## FAB Button
    return Scaffold(
      //######################################################################## AppBar HOME
      appBar: MainAppBar(),
      drawer: Drawer(

        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: drawerOptions),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      floatingActionButton: (_selectedDrawerIndex == 0)
          // Controllo se sto in home oppure no in modo tale da mostrare o non mostrare il fab
          ? Builder(builder: (BuildContext contextSc) {
              return MainFab(contextSc);
            })

          ///
          /// Qui mi serve un Builder per referenziare poi ai figli del fab
          /// questo scaffold qui
          ///
          : null,
    );
  }
}
