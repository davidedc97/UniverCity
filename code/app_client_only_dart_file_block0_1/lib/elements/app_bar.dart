import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:univer_city_app_block0_1/elements/search_model.dart';


//############################################################################## MainAppBar
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {

  //############################################################################ ActionList
  final actionList = <Widget>[
    //########################################################################SMDescendant<SearchModel>
    ScopedModelDescendant<SearchModel>(
        builder: (context, _, model) => IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              debugPrint('is Searching true');
              model.searching(true);//##########################################Cambiamento nel Model
            },
        ),
    )
  ];

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('UniverCity'),
      actions: widget.actionList,
    );
  }
}


//############################################################################## SearchAppBar
class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {

  Widget _searchbar = TextField(
    decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'search...',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //########################################################################SMDescendant<SearchModel>
      leading: ScopedModelDescendant<SearchModel>(
        builder: (context, _,model)=>IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            debugPrint('is Searching false');
            model.searching(false);//###########################################Cambiamento nel Model
          },
        ),
      ),
      title: _searchbar,
    );
  }
}
