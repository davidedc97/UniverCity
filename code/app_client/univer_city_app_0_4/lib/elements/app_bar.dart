import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/bloc/main_bloc_provider.dart';

//############################################################################## MainAppBar
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  //############################################################################ ActionList


  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    final _blocHome = BlocProvider.of(context);
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          'UniverCity',
          style: TextStyle(
            fontFamily: 'Collegiate',
            fontSize: 32.0,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            debugPrint('is Searching true');
            Navigator.pushNamed(context, '/search');
          },
        ),

      ],
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
  Widget _searchbar() => Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.brown[900],
        ),
        child: TextFormField(
          style: TextStyle(color: Colors.brown[900]),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.brown[100]),
            prefixIcon: Icon(
              Icons.search,
            ),
            hintText: 'search...',
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //########################################################################SMDescendant<SearchModel>
      title: _searchbar(),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.close), onPressed: () => debugPrint('cancel'))
      ],
    );
  }
}
