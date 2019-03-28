import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:univer_city_app_1_1/bloc/comp_form_bloc_provider.dart';

class CompFormScaffold extends StatefulWidget {
  @override
  _CompFormScaffoldState createState() => _CompFormScaffoldState();
}

class _CompFormScaffoldState extends State<CompFormScaffold> {

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CompFormBloc bloc = CompFormBlocProvider.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 64),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height-500,
                      ),
                      Text(
                        'COMPLICATED FORM',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      StreamBuilder<String>(
                          stream: bloc.userName,
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'User',
                                  errorText: snapshot.error,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor))),
                              onChanged: bloc.onUserNameChanged,
                            );
                          }),
                      StreamBuilder<String>(
                          stream: bloc.nome,
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Nome',
                                  errorText: snapshot.error,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor))),
                              onChanged: bloc.onNomeChanged,
                            );
                          }),
                      StreamBuilder<String>(
                          stream: bloc.cognome,
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Cognome',
                                  errorText: snapshot.error,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor))),
                              onChanged: bloc.onCognomeChanged,
                            );
                          }),
                      StreamBuilder<String>(
                          stream: bloc.email,
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  errorText: snapshot.error,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor))),
                              onChanged: bloc.onEmailChanged,
                              keyboardType: TextInputType.emailAddress,
                            );
                          }),
                      StreamBuilder<String>(
                          stream: bloc.password,
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            return TextField(
                              obscureText: _obscureText,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  suffix: GestureDetector(child: Text(
                                      _obscureText
                                          ? 'mostra'
                                          : 'nascondi',
                                      style:TextStyle(color: Theme.of(context).accentColor,fontSize: 14)
                                  ),onTap: _toggle,),
                                  hintText: '            Password',
                                  errorText: snapshot.error,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor))),
                              onChanged: bloc.onPasswordChanged,
                              keyboardType: TextInputType.emailAddress,
                            );
                          }),
                      StreamBuilder<String>(
                          stream: bloc.facolta,
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Facoltà',
                                  errorText: snapshot.error,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor))),
                              onChanged: bloc.onFacoltaChanged,
                            );
                          }),
                      StreamBuilder<String>(
                          stream: bloc.universita,
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Università',
                                  errorText: snapshot.error,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor))),
                              onChanged: bloc.onUniversitaChanged,
                            );
                          }),
                      SizedBox(
                        height: 42,
                      ),
                      //################################################################ Get Started Button
                      BtnLogin(context,
                        color: Theme.of(context).accentColor,
                        title: 'REGISTRATI',
                        onPressed: () => compForm(context),
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
                                  style: TextStyle(color: Theme.of(context).accentColor)))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                left: 8,
                top: 32,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false))),
          ]),


    );
  }
}

compForm(BuildContext context) async{
  final CompFormBloc bloc = CompFormBlocProvider.of(context);
  if (bloc.userNameValue == '' ||
      bloc.nomeValue == '' ||
      bloc.cognomeValue == '' ||
      bloc.emailValue == '' ||
      bloc.passwordValue == '' ||
      bloc.facoltaValue == '' ||
      bloc.universitaValue == '') {
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
    debugPrint('User: ${bloc.userNameValue}, Nome: ${bloc.nomeValue}, Cognome: ${bloc.cognomeValue}, Email: ${bloc.emailValue}, Pass: ${bloc.passwordValue}, Facolta ${bloc.facoltaValue}, Universita: ${bloc.universitaValue} ');
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Un attimo!",),
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
        }
    );
    int res = await HttpHandler.userFormRegistration(bloc.userNameValue, bloc.nomeValue, bloc.cognomeValue, bloc.emailValue, bloc.passwordValue, bloc.facoltaValue, bloc.universitaValue);
    debugPrint(res.toString());

    if(res==1){
      debugPrint('dentro if');
      Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed('/loginForm');
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Yay !'),
              content: Text('Registrazione avvenuta con sccesso conferma il tuo account tramite email'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'))
              ],
            );
          }
      );
    }else{
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/complicatedForm');
      showDialog(
          context: context,
          builder: (context){
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
          }
      );
    }
  }
}
