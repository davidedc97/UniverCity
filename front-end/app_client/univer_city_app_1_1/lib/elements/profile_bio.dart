import 'package:flutter/material.dart';

class ProfileBio extends StatelessWidget {
  final String bio;
  ProfileBio(this.bio);
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
                  FlatButton(
                      onPressed: () {
                        editBio(context);
                      },
                      child: Text(
                        'modifica',
                        style: TextStyle(
                            color: Theme.of(context).accentColor),
                      ))
                ],
              ),
              leading: Icon(
                Icons.book,
                color: Theme.of(context).accentColor,
              ),
              subtitle: Text(bio),
            ),
          ],
        ),
      ),
    );
  }
}

editBio(context) {
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
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    label: Text('SALVA'))
              ],
            ),
          )));
}