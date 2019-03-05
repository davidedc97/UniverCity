import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/button_login.dart';
import 'package:univer_city_app_0_4/http_handling/http_handler.dart';

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
                    onPressed: () => Navigator.pop(context))),
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
                      Text('Forgot password?'),
                      FlatButton(

                        ///Login per ora ti rimanda nell'home page
                        ///Poi ci saranno da gestire piu cose
                          onPressed: () {
                            debugPrint('Recover');
                          },
                          child: Text('RECOVER',
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
login(BuildContext context, String id, String pw) {
  if (id == '' || pw == '') {
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
    Future res = HttpHandler.validateLogin(id, pw, 0); //TODO controllare se l'id è un username o una mail e settare il flag di conseguenza
    FutureBuilder<int>(
      ///
      ///   1 if the user is in the Db and the password is correct
      ///  -1 if no user is found or the password is invalid
      ///  -2 if there's an internal error
      ///
      future: res,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.data);
        return snapshot.hasData
            ? (snapshot.data == 1)
                ? Navigator.pushNamedAndRemoveUntil(
                    context, '/', (Route<dynamic> route) => false)
                : showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Ops!'),
                        content: (snapshot.data == -1)
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
                    })
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
