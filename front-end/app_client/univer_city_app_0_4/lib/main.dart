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
// TODO BUG in app

///
/// ThemeData({
//Brightness brightness,
//MaterialColor primarySwatch,
//Color primaryColor,
//Brightness primaryColorBrightness,
//Color primaryColorLight,
//Color primaryColorDark,
//Color accentColor,
//Brightness accentColorBrightness,
//Color canvasColor,
//Color scaffoldBackgroundColor,
//Color bottomAppBarColor,
//Color cardColor,
//Color dividerColor,
//Color highlightColor,
//Color splashColor,
//InteractiveInkFeatureFactory splashFactory,
//Color selectedRowColor,
//Color unselectedWidgetColor,
//Color disabledColor,
//Color buttonColor,
//ButtonThemeData buttonTheme,
//Color secondaryHeaderColor,
//Color textSelectionColor,
//Color cursorColor,
//Color textSelectionHandleColor,
//Color backgroundColor,
//Color dialogBackgroundColor,
//Color indicatorColor,
//Color hintColor,
//Color errorColor,
//Color toggleableActiveColor,
//String fontFamily,
//TextTheme textTheme,
//TextTheme primaryTextTheme,
//TextTheme accentTextTheme,
//InputDecorationTheme inputDecorationTheme,
//IconThemeData iconTheme,
//IconThemeData primaryIconTheme,
//IconThemeData accentIconTheme,
//SliderThemeData sliderTheme,
//TabBarTheme tabBarTheme,
//CardTheme cardTheme,
//ChipThemeData chipTheme,
//TargetPlatform platform,
//MaterialTapTargetSize materialTapTargetSize,
//PageTransitionsTheme pageTransitionsTheme,
//AppBarTheme appBarTheme,
//BottomAppBarTheme bottomAppBarTheme,
//ColorScheme colorScheme,
//DialogTheme dialogTheme,
//Typography typography,
//CupertinoThemeData cupertinoOverrideTheme
//})
///

List<ThemeData> tData = [
  ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],//Colors.brown[100],
    primaryColor: Colors.white,//Colors.cyan[900],
    primaryColorDark: Colors.grey[400],
    accentColor: Colors.redAccent,//Colors.brown[800],
    fontFamily: 'Bahnschrift',
  ),
  ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],//Colors.brown[100],
    primaryColorDark: Colors.grey[400],
    primaryColor: Colors.white,//Colors.cyan[900],
    accentColor: Colors.orangeAccent,//Colors.brown[800],
    fontFamily: 'Bahnschrift',
  ),
  ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.grey[50],
    bottomAppBarColor: Colors.white,
    fontFamily: 'Bahnschrift',
  ),
  ThemeData(
    scaffoldBackgroundColor: Colors.grey[300],
    primaryColor: Colors.cyan[600],
    primaryColorDark: Colors.cyan[700],
    primaryColorLight: Colors.cyan[500],
    accentColor: Colors.grey[700],
    fontFamily: 'Bahnschrift',
  ),
  ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    primaryColor: Colors.red[500],
    primaryColorDark: Colors.red[600],
    primaryColorLight: Colors.red[400],
    accentColor: Colors.cyan[600],
    cardColor: Colors.grey[400],
    fontFamily: 'Bahnschrift',
  ),
];

void main(){
  // rende possibile solo l'orientamento verticale
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_){
    runApp(UniverCity());
  });
}

class UniverCity extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'UniverCity PREALPHA',
        theme: tData[4],
        initialRoute: '/login',
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
      case '/login':
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
      // #######################################################################Upload Form

      // #######################################################################Schermata Home (MainScaffold)
      case '/':
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
