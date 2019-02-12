import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/routes/login_scaffold.dart';
import 'package:univer_city_app_0_4/routes/main_scaffold.dart';
import 'package:univer_city_app_0_4/routes/search_scaffold.dart';
import 'package:univer_city_app_0_4/routes/page_404_not_found.dart';
import 'package:univer_city_app_0_4/bloc/main_bloc_provider.dart';

// TODO creare pagina login
// TODO test pdf online
// TODO feedbak
// TODO BUG

void main() => runApp(UniverCity());

class UniverCity extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniverCity PREALPHA',
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.brown[100],

          primaryColor: Colors.cyan[900],
          accentColor: Colors.brown[800],
          fontFamily: 'Bahnschrift',
      ),
      initialRoute: '/login',
      onGenerateRoute: _myRoutes,
    );
  }

  Route _myRoutes(RouteSettings settings){

    switch(settings.name){
      case '/login':
        return MaterialPageRoute(
            builder: (context){
              return BlocProvider(
                child: LoginScaffold(),
              );
            }
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context){
            return BlocProvider(
                child: MainScaffold(),
              );
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
