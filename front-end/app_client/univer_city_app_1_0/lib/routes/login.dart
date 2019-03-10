import 'package:univer_city_app_0_4/elements/elements.dart';

class LoginScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginBody(context),
    );
  }

  /// body per il Login
  _loginBody(context) {
    return Column(children: <Widget>[
      ///
      ///
      /// Spazio per immagine di sfondo per il login
      ///
      ///
      Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/bgLogin.png'),
                    fit: BoxFit.fitWidth)),
          )),

      ///
      ///
      /// Spazio per i bottoni del login
      ///
      ///
      Expanded(
        child: SizedBox.expand(
            child: Container(
                padding: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 4.0,
                      color: Colors.black,
                      offset: Offset(0.0, 0.0))
                ]),
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
                    BtnLogin(
                      title: 'REGISTRATI CON GOOGLE',
                      color: Theme.of(context).accentColor,
                      onPressed: () => _oAuth(context),
                    ),
                    //################################################## ------------ OR -----------
                    DividerTextOr(),
                    BtnLogin(
                      title: 'COMPILA LA NOSTRA FORM',
                      color: Theme.of(context).accentColor,
                      onPressed: () =>_compFormBtnRen(context),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Hai già un account ?'),
                        FlatButton(
                            ///Login per ora ti rimanda nell'home page
                            ///Poi ci saranno da gestire piu cose
                            onPressed: () => _loginBtnRen(context),
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

///
///
////////////////////////////////////////////////// Function Btn ////////////////
///
///

///
/// Funzione bottone oAuth
///
_oAuth(context){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "OAuth",
          ),
          content: Text('Non ancora implementato'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
                  //Navigator.pop(context);
                },
                child: Text('Close'))
          ],
        );
      });
}

///
/// Funzione bottone registrazione
///
_compFormBtnRen(context){
  Navigator.pushNamed(context, '/complicatedForm');
}

///
/// Funzione bottone login
///
_loginBtnRen(context){
  Navigator.pushNamed(context, '/loginForm');
}