import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';

class LoginScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginBody(context),
    );
  }

  /// body per il Login
  loginBody(context) {
    ThemeBloc tBloc = ThemeBlocProvider.of(context);
    return Column(children: <Widget>[
      ///
      ///
      /// Spazio per un eventuale logo o immagine di sfondo per il login
      ///
      ///
      Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/img/sfondo-login.png'),fit: BoxFit.fitWidth),
                gradient: LinearGradient(colors: [
                  tBloc.firstColorGradient,
                  Theme.of(context).accentColor,
                ])
            ),
            //color: Theme.of(context).scaffoldBackgroundColor,
          )),

      ///
      ///
      /// Spazio per i bottoni del login
      ///
      ///Expanded infatti dice di espandersi
      Expanded(
        child: SizedBox.expand(
            child: Container(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                decoration: boxBgeOmbra(Theme.of(context).scaffoldBackgroundColor), // Applico sfondo bianco e ombra
                child: Column(
                  ///
                  ///Centro la colonna
                  ///
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /// Qui ci sono i bottoni che appariranno nella schermata
                    /// in basso dentro il container con sfondo bianco e
                    /// ombreggiato i [BtnLogin] sono dei wrap a dei bottoni
                    /// personalizzati da me e per comodita nel caso voglia
                    /// modificarli modofico la classe e sono apposto
                    //##################################################inizio bottone google
                    /*BtnLogin(context,
                      title: 'REGISTRATI CON GOOGLE',
                      color: Theme.of(context).accentColor,
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("OAuth",),
                              content: Text('Non ancora implementato'),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(context, '/intro', (Route<dynamic> route) => false);
                                      //Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
                                      //Navigator.pop(context);
                                    },
                                    child: Text('Close'))
                              ],
                            );
                          }
                      ),
                      //Navigator.pushNamedAndRemoveUntil(
                      //                          context, '/home', (Route<dynamic> route) => false)
                    ),*/
                    BtnLogin(context,
                      title: 'ACCEDI',
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginForm');
                      },
                    ),
                    //################################################## ------------ OR -----------
                    DividerTextOr(),
                    //################################################## bottone form complicata
                    BtnLogin(context,
                      title: 'REGISTRATI CON LA NOSTRA FORM',
                      color: Theme.of(context).accentColor,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/complicatedForm'),
                    ),
                    //################################################## LOGIN if already have an account
                    /*Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Hai già un account ?'),
                        FlatButton(

                            ///Login per ora ti rimanda nell'home page
                            ///Poi ci saranno da gestire piu cose
                            onPressed: () {
                              Navigator.pushNamed(context, '/loginForm');
                            },
                            child: Text('LOGIN',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor)))
                      ],
                    )*/
                  ],
                ))),
      ),
    ]);
  }
}
