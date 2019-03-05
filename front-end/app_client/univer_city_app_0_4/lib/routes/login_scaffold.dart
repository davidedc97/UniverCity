import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/box_decoration.dart';
import 'package:univer_city_app_0_4/elements/button_login.dart';
import 'package:univer_city_app_0_4/elements/divider_text.dart';

class LoginScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginBody(context),
    );
  }

  /// body per il Login
  loginBody(context) {
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
              image: DecorationImage(image: AssetImage('assets/img/sfondo_login.png'), fit: BoxFit.fitWidth)
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
                padding: EdgeInsets.only(top: 25),
                decoration: boxBgeOmbra, // Applico sfondo bianco e ombra
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
                    BtnLogin(
                      title: 'JOIN US WITH GOOGLE',
                      color: Theme.of(context).accentColor,
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (Route<dynamic> route) => false),
                    ),
                    //################################################## ------------ OR -----------
                    DividerTextOr(),
                    //################################################## bottone form complicata
                    BtnLogin(
                      title: 'JOIN US WITH A COMPLICATED FORM',
                      color: Theme.of(context).accentColor,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/complicatedForm'),
                    ),
                    //################################################## LOGIN if already have an account
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Already have an account?'),
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
                    )
                  ],
                ))),
      ),
    ]);
  }
}
