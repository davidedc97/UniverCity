import 'package:flutter/material.dart';
import 'package:univer_city_app_0_3/routes/main_scaffold.dart';
import 'package:univer_city_app_0_3/routes/search_scaffold.dart';
import 'package:univer_city_app_0_3/routes/page_404_not_found.dart';

void main() => runApp(UniverCity());

class UniverCity extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniverCity PREALPHA',
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.brown[100],

          primaryColor: Colors.amber[200],
          accentColor: Colors.brown[900],
          fontFamily: 'Bahnschrift',
      ),
      onGenerateRoute: _myRoutes,
    );
  }

  Route _myRoutes(RouteSettings settings){

    switch(settings.name){
      case '/':
        return MaterialPageRoute(
          builder: (context){
            return MainScaffold();
          }
        );
      case '/search':
        return MaterialPageRoute(
          builder: (context){
            return SearchScaffold();
          }
        );
        default:
            return MaterialPageRoute(
                builder: (context){
                  return Page404NotFound();
                }
            );
    }
  }
}