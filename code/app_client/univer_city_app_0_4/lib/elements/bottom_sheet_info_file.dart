import 'package:flutter/material.dart';

class BottomSheetInfoFile extends StatelessWidget {
  final String title, proprietario, rank, downloads;

  BottomSheetInfoFile(this.title, this.proprietario, this.rank, this.downloads);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 282,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text(title),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.thumb_up), onPressed: ()=>debugPrint('like')),
                  IconButton(icon: Icon(Icons.thumb_down), onPressed: ()=>debugPrint('dislike')),
                  IconButton(icon: Icon(Icons.favorite_border), onPressed: ()=>debugPrint('love'))
                ],
              ),
            ),
          ),
          Divider(),
          InfoRow('Proprietario', proprietario),
          InfoRow('Rank', rank),
          InfoRow('Downloads', downloads),
          Divider(),
          ListTile(
            leading: Icon(Icons.content_copy),
            title: Text('Copia Link'),
            onTap: () => debugPrint('url'),
          ),

          ListTile(
            leading: Icon(Icons.file_download),
            title: Text('Scarica'),
            onTap: ()=> debugPrint('downloading'),
          )
        ],
      ),
    );
  }
}


class InfoRow extends StatelessWidget {
  final String _title, _data;
  InfoRow(this._title, this._data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_title),
          Text(_data),
        ],
      ),
    );
  }
}
