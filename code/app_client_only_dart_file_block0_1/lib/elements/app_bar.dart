import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:univer_city_app_block0_1/elements/s_model.dart';



//############################################################################## MainAppBar
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {

  //############################################################################ ActionList
  final actionList = <Widget>[
    //########################################################################SMDescendant<SearchModel>
    ScopedModelDescendant<SModel>(
      rebuildOnChange: false,
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
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0) ,
        child: Image.asset('assets/images/topbarlogo.png', fit: BoxFit.contain),
      ), //Text('UniverCity'),
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

  Widget _searchbar() => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.white, ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.pink[700]),
          prefixIcon: Icon(Icons.search,),
          hintText: 'search...',
        ),
      ),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //########################################################################SMDescendant<SearchModel>
      leading: ScopedModelDescendant<SModel>(
        rebuildOnChange: false,
        builder: (context, _,model)=>IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            debugPrint('is Searching false');
            model.searching(false);//###########################################Cambiamento nel Model
          },
        ),
      ),
      title: _searchbar(),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.close), onPressed: ()=> debugPrint('cancel'))
      ],
    );
  }
}
