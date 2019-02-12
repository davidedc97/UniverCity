import 'package:flutter/material.dart';

class LoginScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.brown[100],
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                    child: Container(
                      color: Colors.brown[100],
                    )),
                Expanded(
                  child: SizedBox.expand(
                    child: Container(
                      padding: EdgeInsets.only(top: 25),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4.0,
                                  color: Colors.black,
                                  offset: Offset(0.0, 0.0))
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //##################################################inizio bottone google
                            SizedBox(
                              width: 300,
                              height: 45,
                              child: RaisedButton(
                                  color: Colors.lightGreenAccent[700],
                                  child: Text('JOIN US WITH GOOGLE'),
                                  onPressed: () =>
                                      debugPrint('test google join'))),
                            //################################################## ------------ OR -----------
                            SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(height: 1.5, width: 120,color: Colors.grey,margin: EdgeInsets.only(right: 12),),
                                  Text('OR'),
                                  Container(height: 1.5, width: 120,color: Colors.grey,margin: EdgeInsets.only(left: 12),),
                                ],
                              ),
                            ),
                            //################################################## bottone form complicata
                            SizedBox(
                              width: 300,
                              height: 45,
                              child: RaisedButton(
                                  color: Colors.redAccent[700],
                                  child: Text('JOIN US WITH A COMPLICATED FORM'),
                                  onPressed: () => debugPrint('test jooin form'))),
                            //################################################## LOGIN if already have an account
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Alredy have an acount?'),
                                FlatButton(
                                  onPressed: ()=>Navigator.popAndPushNamed(context,'/home'),
                                  child: Text('LOGIN',
                                    style: TextStyle(color: Colors.redAccent[700])))
                              ],
                            )
                          ],

                        )),
                  ),
                )
              ],
            )));
  }
}
