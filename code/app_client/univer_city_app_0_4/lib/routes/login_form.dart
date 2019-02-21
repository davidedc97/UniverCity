import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/button_login.dart';
import 'package:univer_city_app_0_4/bloc/main_bloc_provider.dart';

class LoginFormScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of(context);

    bloc.getEmail.listen((val){debugPrint(val);});
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
              Text('LOGIN',style: TextStyle(fontSize: 18),),
              SizedBox(height: 24,),
              TextField(
                onChanged: (value){
                  bloc.email.add(value);
                },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  )),
              TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  )),
              SizedBox(height: 42,),
              //################################################################ LOGIN BUTTON
              BtnLogin(
                color: Colors.redAccent[700],
                title: 'LOGIN',
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
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
