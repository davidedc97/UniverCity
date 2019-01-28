import 'package:flutter/material.dart';
import 'package:univer_city_app_client_block01/ui_pages/main_scaffold.dart';
import 'package:univer_city_app_client_block01/ui_pages/search_scaffold.dart';
import 'package:univer_city_app_client_block01/elements/s_model.dart';
import 'package:scoped_model/scoped_model.dart';


void main() => runApp(UniverCity());

class UniverCity extends StatefulWidget {
  @override
  _UniverCityState createState() => _UniverCityState();
}

class _UniverCityState extends State<UniverCity> {
  //############ Evitare la rotaziojne dello schermo
  //<TODO>


  @override
  Widget build(BuildContext context) {

    return ScopedModel(
      model: SModel(),
      child: MaterialApp(
        title: 'UniverCity PREALPHA',
        theme: ThemeData(
          primaryColor: Colors.pink[900],
          primaryColorLight: Color.fromARGB(255, 188, 71, 123),
          primaryColorDark: Color.fromARGB(255, 148, 2, 70),
          accentColor: Colors.grey[900],
          scaffoldBackgroundColor: Colors.grey[300],
          cardColor: Colors.white,
          dividerColor: Colors.black,

        ),
        //home: MainScaffold(),
        //######################################################################SMDescendant<SearchModel>
        home: ScopedModelDescendant<SModel>(
          builder: (context, _, model)=>(model.isSearching)
              ?SearchScaffold()
              :MainScaffold(),
        ),
        //home: SearchScaffold(),
      ),
    );
  }
}
