import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/button_login.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class LoginFormScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _usem, _pw;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
            Positioned(
                left: 8,
                top: 32,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                      onChanged: (value) {
                        //bloc.email.add(value);
                        _usem = value;
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'User o Email',
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor))
                      )),
                  TextField(
                      obscureText: true,
                      onChanged: (value) {
                        _pw = value;
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor))
                      )),
                  SizedBox(
                    height: 42,
                  ),
                  //################################################################ LOGIN BUTTON
                  BtnLogin(
                    color: Theme.of(context).accentColor,
                    title: 'LOGIN',
                    onPressed: () {
                      login(context, _usem ?? '', _pw ?? '');
                    },
                  ),
                  //################################################## LOGIN if already have an account
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Password dimenticata ?'),
                      FlatButton(

                        ///Login per ora ti rimanda nell'home page
                        ///Poi ci saranno da gestire piu cose
                          onPressed: () {
                            debugPrint('Recover');
                          },
                          child: Text('RECUPERA',
                              style: TextStyle(color: Theme.of(context).accentColor)))
                    ],
                  )
                ],
              ),
            ),
          ]),
    );
  }
}

///
/// controllo form
///
login(BuildContext context, String id, String pw)async{
  if (id == '' || pw == '') {
    Navigator.pushNamed(context, '/loginForm');
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ops!'),
            content: Text('something in the form is not valid'),
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
    debugPrint('email: $id, pass: $pw ');
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Un attimo che controlliamo!",),
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
    int res = await HttpHandler.validateLogin(id, pw, "0"); //TODO controllare se l'id è un username o una mail e settare il flag di conseguenza
    debugPrint(res.toString());

    if(res==1){
      debugPrint('dentro if');
      Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
    }else{
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/loginForm');
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Ops !'),
              content: (res == -1)
                  ? Text('incorrect user or password')
                  : Text('server error'),
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
