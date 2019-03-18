import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/info_row.dart';

Widget buildDocDialog(BuildContext context, String title, String uuid) =>
    Dialog(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage('assets/img/sfondo_login3.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      ListTile(leading: Icon(Icons.info), title: Text(title)),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            OutlineButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.thumb_up),
                              label: Text('Like'),
                              textColor: Colors.greenAccent,
                              highlightColor: Colors.greenAccent[100],
                              highlightedBorderColor: Colors.greenAccent,
                            ),
                            OutlineButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.thumb_down),
                              label: Text('Dislike'),
                              textColor: Colors.redAccent,
                              highlightColor: Colors.redAccent[100],
                              highlightedBorderColor: Colors.redAccent,
                            ),
                            OutlineButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
                              label: Text('Save'),
                              textColor: Colors.blueAccent,
                              highlightColor: Colors.blueAccent[100],
                              highlightedBorderColor: Colors.blueAccent,
                            ),
                          ]),
                      Divider(),
                      InfoRow('Proprietario', 'todo'),
                      InfoRow('Rank', 'todo'),
                      InfoRow('Downloads', 'todo'),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.feedback),
                        title: Text('Segnala'),
                        onTap: () {},
                        dense: true,
                      ),
                      ListTile(
                        leading: Icon(Icons.local_offer),
                        title: Text('Aiutaci con i tag'),
                        onTap: () {},
                        dense: true,
                      ),
                      ListTile(
                        leading: Icon(Icons.file_download),
                        title: Text('Scarica'),
                        onTap: () {},
                        dense: true,
                      ),
                      ListTile(
                        leading: Icon(Icons.share),
                        title: Text('Condividi link'),
                        onTap: () {},
                        dense: true,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(
                top: 125,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: FloatingActionButton.extended(
                      backgroundColor: Color(0xFF393E46),
                      onPressed: () {},
                      icon: Icon(Icons.play_arrow),
                      label: Text('PLAY'),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
