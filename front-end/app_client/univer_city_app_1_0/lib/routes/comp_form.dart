import 'package:univer_city_app_1_0/elements/elements.dart';
import 'package:univer_city_app_1_0/http_handling/http_handler.dart';
import 'package:univer_city_app_1_0/bloc/comp_form_bloc_provider.dart';

class CompForm extends StatelessWidget {
  String _nm, _fa, _cg, _us, _un;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _compFormBody(context),
    );
  }
  
  _compFormBody(context){
    final CompFormBloc _registrationFormBloc = CompFormBlocProvider.of(context);
    return Stack(children: <Widget>[
      ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height - 500,
                ),
                Text(
                  'COMPLICATED FORM',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                    onChanged: (value) {_us = value;},
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'User',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)))),
                TextField(
                    onChanged: (value) {_nm = value;},
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Nome',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)))),
                TextField(
                    onChanged: (value) {_cg = value;},
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Cognome',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)))),
                StreamBuilder<String>(
                    stream: _registrationFormBloc.email,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            errorText: snapshot.error,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor))),
                        onChanged: _registrationFormBloc.onEmailChanged,
                        keyboardType: TextInputType.emailAddress,
                      );
                    }),
                StreamBuilder<String>(
                    stream: _registrationFormBloc.password,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            errorText: snapshot.error,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor))),
                        onChanged: _registrationFormBloc.onPasswordChanged,
                        keyboardType: TextInputType.emailAddress,
                      );
                    }),
                TextField(
                    onChanged: (value) {_fa = value;},
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Facoltà',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)))),
                TextField(
                    onChanged: (value) {_un = value;},
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Università',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)))),
                SizedBox(
                  height: 42,
                ),
                //################################################################ Get Started Button
                BtnLogin(
                  color: Theme.of(context).accentColor,
                  title: 'REGISTRATI',
                  onPressed: () => compForm(context, _us ?? '', _nm ?? '',
                      _cg ?? '', _registrationFormBloc.email ?? '', _registrationFormBloc.password ?? '', _fa ?? '', _un ?? ''),
                ),
                //################################################## LOGIN if already have an account
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Hai già un account ?'),
                    FlatButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/loginForm');
                        },
                        child: Text('LOGIN',
                            style: TextStyle(
                                color: Theme.of(context).accentColor)))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      UndoButton(),
    ]);
  }
  
}

compForm(BuildContext context, String id, String nm, String cg, String em,
    String pw, String fa, String un) async {
  if (id == '' ||
      nm == '' ||
      cg == '' ||
      em == '' ||
      pw == '' ||
      fa == '' ||
      un == '') {
    //Navigator.pushNamed(context, '/complicatedForm');
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ops!'),
            content: Text('Qualcosa nella form non va :/'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
  } else {
    //TODO da testare
    debugPrint(
        'User: $id, Nome: $nm, Cognome: $cg, Email: $em, Pass: $pw, Facolta $fa, Universita: $un ');
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Un attimo!",
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
    int res =
        await HttpHandler.userFormRegistration(id, nm, cg, em, pw, fa, un);
    debugPrint(res.toString());

    if (res == 1) {
      debugPrint('dentro if');
      Navigator.pushNamedAndRemoveUntil(
          context, '/', (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed('/loginForm');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Yay !'),
              content: Text(
                  'Registrazione avvenuta con successo conferma il tuo account tramite email'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'))
              ],
            );
          });
    } else {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/complicatedForm');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Ops !'),
              content: (res == -1)
                  ? Text('Input non valido')
                  : Text('Errore del server'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'))
              ],
            );
          });
    }
  }
}
