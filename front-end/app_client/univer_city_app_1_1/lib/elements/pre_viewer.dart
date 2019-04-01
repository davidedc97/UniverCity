import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:share/share.dart';

Widget buildDocDialog(BuildContext context, String titolo,String proprietario, String uuid) {
  CronologiaBloc cBloc = CronologiaBlocProvider.of(context);
  ThemeBloc tBloc = ThemeBlocProvider.of(context);
  return Dialog(
    child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    tBloc.firstColorGradient,
                    Theme.of(context).accentColor,
                  ])
              ),
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage('assets/img/sfondo-login.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    ListTile(leading: Icon(Icons.info), title: Text(titolo)),
                    Divider(),
                    PreViewRowButton(uuid),
                    Divider(),
                    InfoRow('Proprietario', proprietario),
                    //InfoRow('Rank', 'todo'),
                    //InfoRow('Downloads', 'todo'),
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
                      onTap: () {
                        Share.share('Dai un occhiata a $titolo, lo trovi qui: URLDELFILERAGGIUNGIBILE DA INTERNET');
                      },
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
                    backgroundColor: (tBloc.state)?Color(0xFF0E688D):Color(0xFF147ECC),
                    onPressed: () async{
                      cBloc.addInCronologia(CronologiaEntry(uuid, titolo, proprietario));
                      var byte = await HttpHandler.getDocumentById(uuid);
                      PdfViewer.loadBytes(byte);
                    },
                    icon: Icon(Icons.play_arrow, color: Colors.white,),
                    label: Text('LEGGI', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ))
      ],
    ),
  );
}



class PreViewRowButton extends StatefulWidget {
  String uuid;
  PreViewRowButton(this.uuid);
  @override
  _PreViewRowButtonState createState() => _PreViewRowButtonState();
}

class _PreViewRowButtonState extends State<PreViewRowButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton.icon(
            onPressed: () async{
              HttpHandler.addLike(SessionUser().user, widget.uuid);
            },
            icon: Icon(Icons.thumb_up),
            label: Text('Like'),
            textColor: Colors.greenAccent,
            highlightColor: Colors.greenAccent[100],
          ),
          FlatButton.icon(
            onPressed: () {
              HttpHandler.retrieveLikes(widget.uuid);
            },
            icon: Icon(Icons.thumb_down),
            label: Text('Dislike'),
            textColor: Colors.redAccent,
            highlightColor: Colors.redAccent[100],
          ),
          FlatButton.icon(
            onPressed: () async{
              //TODO vedi come si puo migliorare il fatto che se gia sta tra i preferiti è da eliminare
              HttpHandler.addUserFavourite(SessionUser().user, widget.uuid);
            },
            icon: Icon(Icons.favorite_border),
            label: Text('Save'),
            textColor: Colors.blueAccent,
            highlightColor: Colors.blueAccent[100],
          ),
        ]);
  }
}
