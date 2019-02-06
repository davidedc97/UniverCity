import 'package:flutter/material.dart';
import 'package:univer_city_app_0_3/elements/app_bar.dart';
import 'package:univer_city_app_0_3/elements/fab_home.dart';
import 'package:univer_city_app_0_3/bodies_drawer/history.dart';
import 'package:univer_city_app_0_3/bodies_drawer/home.dart';
import 'package:univer_city_app_0_3/bodies_drawer/mashups.dart';
import 'package:univer_city_app_0_3/bodies_drawer/report_bug.dart';
import 'package:univer_city_app_0_3/bodies_drawer/send_feedback.dart';
import 'package:univer_city_app_0_3/bloc/home_provider.dart';

class DrawerEntry {
  String title;
  IconData icon;
  DrawerEntry(this.title, this.icon);
}

class MainScaffold extends StatefulWidget {
//############################################################################## drawer entry
  final drawerEntry = [
    DrawerEntry('My Place', Icons.home),
    DrawerEntry('My History', Icons.history),
    DrawerEntry('Mashups', Icons.insert_drive_file),
    DrawerEntry('Send feedback', Icons.feedback),
    DrawerEntry('Report bug', Icons.bug_report),
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
        return HomeProvider(
          child: MyHome(),
        );
      case 1:
        return MyHistory();
      case 2:
        return Mashups();
      case 3:
        return SendFeedback();
      case 4:
        return ReportBug();
      case 5:
        return Text('Logout non implementato');
      default:
        return Text('Errore switch Drawer outOfIndex ;) ');
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // chiude il drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerEntry.length; i++) {
      var d = widget.drawerEntry[i];
      drawerOptions.add(
        Container(
          decoration: BoxDecoration(
            color: (i == _selectedDrawerIndex)
                ?Colors.brown
                :null,
          ),
          child: ListTile(
            leading: Icon(d.icon),
            title: Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          ),
        )
      );
    }

    //########################################################################## FAB Button
    return Scaffold(
      //######################################################################## AppBar HOME
        appBar: MainAppBar(),
        drawer: Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: drawerOptions),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        floatingActionButton: (_selectedDrawerIndex == 0)
        // Controllo se sto in home oppure no in modo tale da mostrare o non mostrare il fab
            ? MainFab()
            : null);
  }
}
