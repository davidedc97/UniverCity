import 'package:flutter/material.dart';
import 'package:univer_city_app_block0_1/ui_pages/home.dart';
import 'package:univer_city_app_block0_1/ui_pages/history.dart';
import 'package:univer_city_app_block0_1/ui_pages/report_bug.dart';
import 'package:univer_city_app_block0_1/ui_pages/send_feedback.dart';
import 'package:univer_city_app_block0_1/ui_pages/mashups.dart';

class DrawerEntry{
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

  _getDrawerItemWidget(int index){
    switch(index){
      case 0:
        return MyHome();
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
      default :
        return Text('Errore switch Drawer outOfIndex ;) ');
    }
  }

  _onSelectItem(int index){
    setState(()=>_selectedDrawerIndex = index);
    Navigator.of(context).pop(); // chiude il drawer
  }



  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for(var i=0; i< widget.drawerEntry.length; i++){
      var d = widget.drawerEntry[i];
      drawerOptions.add(
        ListTile(
          leading: Icon(d.icon),
          title: Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }
//############################################################################## ActionList
    var actionList = <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: ()=> debugPrint('Premuto'),
      )
    ];


    return Scaffold(
      //######################################################################## AppBar HOME
      appBar: AppBar(
        title: Text('UniverCity'),
        actions: actionList,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: drawerOptions
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

