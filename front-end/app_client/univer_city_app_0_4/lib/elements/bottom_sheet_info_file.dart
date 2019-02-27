import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/info_row.dart';


///
/// Classe che costruisce il BottomSheet con le informazioni del documento
/// selezionato, il costruttore prende come valori:
/// title -> il titolo del documento
/// proprietario -> il proprietario del documento
/// uuid -> l'indentificatore univoco del documento
///         per eventuali interrogazioni al database dei metadati
///         riguardo il documento in questione
///

class BottomSheetInfoFile extends StatelessWidget {
  final String title, proprietario, _uuid;

  BottomSheetInfoFile(this.title, this.proprietario, this._uuid);

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
                  IconButton(icon: Icon(Icons.thumb_up), onPressed: ()=>debugPrint('like')),//TODO ADD LIKE
                  IconButton(icon: Icon(Icons.favorite_border), onPressed: ()=>debugPrint('love'))//TODO ADD AND REMOVE TO DB Favorite
                ],
              ),
            ),
          ),
          Divider(),
          InfoRow('Proprietario', proprietario),
          InfoRow('Rank', 'todo'),
          InfoRow('Downloads', 'todo'),
          Divider(),
          ListTile(
            leading: Icon(Icons.content_copy),
            title: Text('Copia Link'),
            onTap: () => debugPrint('url'),//TODO copia link
          ),

          ListTile(
            leading: Icon(Icons.file_download),
            title: Text('Scarica'),
            onTap: ()=> debugPrint('downloading $_uuid'),//TODO DOWNLOAD UUID
          )
        ],
      ),
    );
  }
}
