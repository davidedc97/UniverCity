import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/button_login.dart';

class CompFormScaffold extends StatelessWidget {

  String _nm, _em, _pw, _fa, _cg, _us;

  @override
  Widget build(BuildContext context) {
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
              Text('COMPLICATED FORM',style: TextStyle(fontSize: 18),),
              SizedBox(height: 24,),
              TextField(
                  onChanged: (value){_us=value;},
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'User',
                  )),
              TextField(
                  onChanged: (value){_nm=value;},
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                  )),
              TextField(
                  onChanged: (value){_cg=value;},
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Cognome',
                  )),
              TextField(
                  onChanged: (value){_em=value;},
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  )),
              TextField(
                  obscureText: true,
                  onChanged: (value){_pw=value;},
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  )),
              TextField(
                  onChanged: (value){_fa=value;},
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Facoltà',
                  )),
              SizedBox(height: 42,),
              //################################################################ Get Started Button
              BtnLogin(
                color: Colors.redAccent[700],
                title: 'GET STARTED',
                onPressed: ()=>debugPrint('user: $_us, nome: $_nm,cognome: $_cg email: $_em, password: $_pw, facolta $_fa'),
              ),
              //################################################## LOGIN if already have an account
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Alredy have an acount?'),
                  FlatButton(

                    ///Login per ora ti rimanda nell'home page
                    ///Poi ci saranno da gestire piu cose
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/loginForm');
                      },
                      child: Text('LOGIN',
                          style: TextStyle(color: Colors.redAccent[700])))
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
