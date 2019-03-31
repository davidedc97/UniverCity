import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';

class ProfileBio extends StatelessWidget {
  final String bio;
  final String flag;
  ProfileBio(this.bio, this.flag);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Descrizione'),
                  flag=='mod'
                      ?FlatButton(
                      onPressed: () {
                        editBio(context);
                      },
                      child: Text(
                        'modifica',
                        style: TextStyle(
                            color: Theme.of(context).accentColor),
                      ))
                      :Container()
                ],
              ),
              leading: Icon(
                Icons.book,
                color: Theme.of(context).accentColor,
              ),
              subtitle: Text(bio),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}

editBio(context) {
  String bio;
  showDialog(
      context: context,
      builder: (context) => Dialog(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Modifica la tua descrizione'),
                SizedBox(
                  height: 18,
                ),
                TextField(
                  onChanged: (t){bio=t;},
                  cursorColor: Theme.of(context).accentColor,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: 'Inserisci la tua descrizione...',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor))),
                ),
                SizedBox(
                  height: 18,
                ),
                FlatButton.icon(
                    onPressed: () {HttpHandler.changeUserBio(SessionUser().user, bio);},
                    icon: Icon(Icons.edit),
                    label: Text('SALVA'))
              ],
            ),
          )));
}