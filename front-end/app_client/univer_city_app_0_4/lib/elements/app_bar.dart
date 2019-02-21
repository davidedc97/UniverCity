import 'package:flutter/material.dart';

//############################################################################## MainAppBar
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {

  ///Serve per specificare di che altezza deve essere l'app bar
  ///Perche deve avere una preferred size
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget _searchbar(context) => Theme(
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
      title: _searchbar(context),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.close), onPressed: () => debugPrint('cancel'))
      ],
    );
  }
}
