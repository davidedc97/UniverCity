import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/button_login.dart';

class CompFormScaffold extends StatelessWidget {
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
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                  )),
              TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  )),
              TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  )),
              TextField(
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
                onPressed: ()=>debugPrint('get started'),
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
