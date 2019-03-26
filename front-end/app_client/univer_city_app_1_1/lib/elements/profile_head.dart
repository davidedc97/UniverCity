import 'package:flutter/material.dart';

class HeadProfile extends StatelessWidget {
  final String userName, pathImage, corsoStudi;
  HeadProfile(this.userName, this.corsoStudi, this.pathImage);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 24, left: 16, bottom: 8, right: 16),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(pathImage),
                fit: BoxFit.cover,
              ),
              borderRadius:
              BorderRadius.all(new Radius.circular(100.0)),
              border: new Border.all(
                color: Theme.of(context).accentColor,
                width: 4.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(fontSize: 20),
                ),
                Text(corsoStudi)
              ],
            ),
          )
        ],
      ),
    );
  }
}
