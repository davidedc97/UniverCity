import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:univer_city_app_0_4/routes/login_scaffold.dart';
import 'package:univer_city_app_0_4/routes/main_scaffold.dart';
import 'package:univer_city_app_0_4/routes/page_404_not_found.dart';
import 'package:univer_city_app_0_4/bloc/main_bloc_provider.dart';
import 'package:univer_city_app_0_4/routes/complicated_form.dart';
import 'package:univer_city_app_0_4/routes/login_form.dart';


// TODO test pdf online
// TODO feedback sistemare


List<ThemeData> tData = [
  ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],//Colors.brown[100],
    primaryColor: Colors.white,//Colors.cyan[900],
    primaryColorDark: Colors.grey[400],
    cardColor: Colors.grey[500],
    accentColor: Color(0xFFE74844),//Colors.brown[800],
    fontFamily: 'Bahnschrift',
  ),
  ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],//Colors.brown[100],
    primaryColor: Colors.white,//Colors.cyan[900],
    primaryColorDark: Colors.grey[400],
    cardColor: Colors.grey[500],
    accentColor: Colors.orangeAccent,
    fontFamily: 'Bahnschrift',
  ),
  ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],//Colors.brown[100],
    primaryColor: Colors.white,//Colors.cyan[900],
    primaryColorDark: Colors.grey[400],
    cardColor: Colors.grey[500],
    accentColor: Color(0xFF00ADB5),
    fontFamily: 'Bahnschrift',
  ),
  ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],//Colors.brown[100],
    primaryColor: Colors.white,//Colors.cyan[900],
    primaryColorDark: Colors.grey[400],
    cardColor: Colors.grey[500],
    accentColor: Color(0xFF822433),//Colors.brown[800],
    fontFamily: 'Bahnschrift',
  ),
];

void main(){
  // rende possibile solo l'orientamento verticale
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_){
    runApp(new UniverCity());
  });
}

class UniverCity extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniverCity PREALPHA',
        theme: tData[0],
        initialRoute: '/',
        onGenerateRoute: _myRoutes,
      ),
    );
  }

  /// [_myRoutes] è la funzione che sfecifica in base alla NamedRoute pop o pushata
  /// cosa mostrare nello schermo. Il valore [settings] assume il valore della route
  /// pushata nello stack, perche lo schermo viene gestito come se fosse uno stack
  /// e le schermate vengono messe una sopra l'altra e l'utente può vedere solo
  /// la più in alto tra le schermate. Ovviamente per evitare uno stack pieno di
  /// roba inutile si usano le funzioni [.popAndPushNamed] che elimina la schermata
  /// al top dello stack e ne pusha un altra in cima, mantenendo sosi lo stack con
  /// la stessa altezza. Oppure [.pushNamedAndRemoveUntil] che rimuove piu schermate
  /// e poppa in cima un'altra schermata
  Route _myRoutes(RouteSettings settings) {
    switch (settings.name) {
      // #######################################################################Schermata di login principale
      case '/':
        return MaterialPageRoute(builder: (context) {
          return LoginScaffold();
        });
      // #######################################################################Schermata Login Form Complicata
      case '/loginForm':
        return MaterialPageRoute(builder: (context) {
          return LoginFormScaffold();
        });
      // #######################################################################Schermata Login Form Complicata
      case '/complicatedForm':
        return MaterialPageRoute(builder: (context) {
          return CompFormScaffold();
        });
      // #######################################################################Schermata Home (MainScaffold)
      case '/home':
        return MaterialPageRoute(builder: (context) {
          return MainScaffold();
        });
      /// in caso di errore non so se mostrare una pagina 404 con vari link
      /// di reindirizzamento oppure reindirizzare nella pagina home
      default:
        return MaterialPageRoute(builder: (context) {
          return Page404NotFound();
        });
    }
  }
}
