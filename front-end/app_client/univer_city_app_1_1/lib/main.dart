import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:univer_city_app_1_1/bloc/comp_form_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/profilo_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/upload_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_search_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/filtri_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/profilo_bloc_provider.dart';
import 'package:univer_city_app_1_1/routes/route.dart';

// TODO test pdf online

void main() {
  // rende possibile solo l'orientamento verticale
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ThemeBlocProvider(
          child: CronologiaSearchBlocProvider(
              child: CronologiaBlocProvider(
                  child: FiltriBlocProvider(
                      child: ProfiloBlocProvider(child: new UniverCity(),))))),
    );
  });
}

class UniverCity extends StatefulWidget {
  @override
  _UniverCityState createState() => _UniverCityState();
}

class _UniverCityState extends State<UniverCity> {
//class UniverCity extends StatelessWidget {
  Widget build(BuildContext context) {
    List<ThemeData> td = <ThemeData>[
      ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primaryColorBrightness: Brightness.light,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.grey[400],
        canvasColor: Colors.grey[350],
        accentColor: Color(0xffc02641),
        accentColorBrightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[100],
        bottomAppBarColor: Colors.grey[300],
        cardColor: Colors.white,
        dividerColor: Color(0x1F000000),
        highlightColor: Color(0x66BCBCBC),
        splashColor: Color(0x66C8C8C8),
        splashFactory: InkSplash.splashFactory,
        selectedRowColor: Colors.grey[100],
        unselectedWidgetColor: Colors.black54,
        disabledColor: Colors.black38,
        buttonColor: Colors.grey[300],
        secondaryHeaderColor: Colors.grey[50],
        textSelectionColor: Colors.grey[200],
        cursorColor: Color(0xffc02641),
        textSelectionHandleColor: Colors.grey[300],
        backgroundColor: Colors.grey[200],
        dialogBackgroundColor: Colors.white,
        indicatorColor: Color(0xffc02641),
        hintColor: Color(0x8A000000),
        errorColor: Color(0xffc02641),
        toggleableActiveColor: Color(0xffc02641),
        textTheme: Typography.blackMountainView,
        primaryTextTheme: Typography.blackMountainView,
        accentTextTheme: Typography.whiteMountainView,
        inputDecorationTheme: InputDecorationTheme(),
        iconTheme: const IconThemeData(color: Colors.black87),
        primaryIconTheme: const IconThemeData(color: Colors.black),
        accentIconTheme: const IconThemeData(color: Colors.black),
        tabBarTheme: const TabBarTheme(),
        cardTheme: CardTheme(shape: BeveledRectangleBorder()),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        pageTransitionsTheme: const PageTransitionsTheme(),
        appBarTheme: const AppBarTheme(),
        bottomAppBarTheme: const BottomAppBarTheme(),
        dialogTheme: const DialogTheme(),
        typography: Typography(platform: defaultTargetPlatform),
      ),
      ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
        primaryColorLight: Colors.grey[500],
        primaryColorDark: Colors.black,
        canvasColor: Colors.grey[850],
        accentColor: Color(0xffffcc00),
        scaffoldBackgroundColor: Colors.grey[850],
        bottomAppBarColor: Colors.grey[800],
        cardColor: Colors.grey[800],
        cardTheme: CardTheme(shape: BeveledRectangleBorder()),
        dividerColor: Color(0x1FFFFFFF),
        cursorColor: Color(0xffffcc00),
        dialogBackgroundColor: Colors.grey[800],
        errorColor: Color(0xffffcc00),
        textTheme: Typography.whiteMountainView,
      )
    ];
    final ThemeBloc tBlock = ThemeBlocProvider.of(context);
    return StreamBuilder(
      stream: tBlock.themeIndex,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'UniverCity PREALPHA',
          theme: td[snapshot.data ?? 0],
          initialRoute: '/',
          onGenerateRoute: _myRoutes,
        );
      },
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
          return CompFormBlocProvider(child: CompFormScaffold());
        });
      // #######################################################################Schermata Home (MainScaffold)
      case '/home':
        return MaterialPageRoute(builder: (context) {
          return PreferitiBlocProvider(
            child: HomeUniverCity(),
          );
        });
      case '/profilo':
        final userName = (settings.arguments as Map)['userName'];
        return MaterialPageRoute(builder: (context) {
          return ProfiloBlocProvider(
            child: Profilo(userName),
          );
        });
      case '/upload':
        final path = (settings.arguments as Map)['path'];
        return MaterialPageRoute(builder: (context) {
          return UploadBlocProvider(child: Upload(path));
        });
      case '/intro':
        return MaterialPageRoute(builder: (context) {
          return Intro();
        });

      /// in caso di errore non so se mostrare una pagina 404 con vari link
      /// di reindirizzamento oppure reindirizzare nella pagina home
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold();
        });
    }
  }
}
