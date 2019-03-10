import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  ///Serve per specificare di che altezza deve essere l'app bar
  ///Perche deve avere una preferred size
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              debugPrint('cerca');
            },
          )
        ]);
  }
}

class MashupAppBar extends StatefulWidget implements PreferredSizeWidget {
  ///Serve per specificare di che altezza deve essere l'app bar
  ///Perche deve avere una preferred size
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _MashupAppBarState createState() => _MashupAppBarState();
}

class _MashupAppBarState extends State<MashupAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            debugPrint('cerca');
          },
        )
      ],
      bottom: TabBar(
        tabs: [
          Tab(text: 'Scegli',),
          Tab(text: 'Componi',),
          Tab(text: 'Carica',),
        ],
      ),
    );
  }
}
