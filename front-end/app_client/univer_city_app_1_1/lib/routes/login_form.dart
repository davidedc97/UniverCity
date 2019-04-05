import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/button_login.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc_provider.dart';

class LoginFormScaffold extends StatefulWidget {
  @override
  _LoginFormScaffoldState createState() => _LoginFormScaffoldState();
}

class _LoginFormScaffoldState extends State<LoginFormScaffold> {
  bool _obscureText = true;
  String _usem, _pw;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {


    print('b, ${_obscureText.toString()}');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: <Widget>[
        Positioned(
            left: 8,
            top: 32,
            child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false))),
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
                      hintText: 'User',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor)))),
              TextField(
                  obscureText: _obscureText,
                  onChanged: (value) {
                    _pw = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      suffix: GestureDetector(child: Text(
                        _obscureText
                            ? 'mostra'
                            : 'nascondi',
                        style:TextStyle(color: Theme.of(context).accentColor,fontSize: 14)
                      ),onTap: _toggle,),
                      border: InputBorder.none,
                      hintText: '            Password',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor)))),
              SizedBox(
                height: 42,
              ),
              //################################################################ LOGIN BUTTON
              BtnLogin(
                context,
                color: Theme.of(context).accentColor,
                title: 'LOGIN',
                onPressed: () {
                  print('$_usem , $_pw');
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
                          style:
                              TextStyle(color: Theme.of(context).accentColor)))
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
login(BuildContext context, String id, String pw) async {
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
    Future<SharedPreferences> loginFlag = SharedPreferences.getInstance();
    debugPrint('email: $id, pass: $pw ');
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Un attimo che controlliamo!",
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

    int res = await HttpHandler.validateLogin(id, pw, "0", PreferitiBlocProvider.of(context));
    debugPrint(res.toString());

    if (res == 1) {

      loginFlag.then((sp) {
        int flag = sp.getInt('intro');
        if (flag == null) {
          sp.setInt('intro', 1);
          Navigator.pushNamedAndRemoveUntil(
              context, '/intro', (Route<dynamic> route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', (Route<dynamic> route) => false);
        }
      });
    } else {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/loginForm');
      showDialog(
          context: context,
          builder: (context) {
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
          });
    }
  }
}
