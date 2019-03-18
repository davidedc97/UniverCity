import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/info_row.dart';

Widget buildDocDialog(BuildContext context, String title, String uuid)=>Dialog(

  child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Image(image: AssetImage('assets/img/sfondo_login3.png'),fit: BoxFit.fitWidth,),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25,),
                    ListTile(
                        leading: Icon(Icons.info), title: Text(title)),
                    Divider(),
                    InfoRow('Proprietario', 'todo'),
                    InfoRow('Rank', 'todo'),
                    InfoRow('Downloads', 'todo'),
                    Divider()
                  ],
                ),
              ),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top:125,),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 200,
                  child: FloatingActionButton.extended(backgroundColor: Color(0xFF393E46), onPressed: (){}, icon: Icon(Icons.play_arrow), label: Text('PLAY'),),
                ),
              ],
            )
        )
      ],
    ),

);