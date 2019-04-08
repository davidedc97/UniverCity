import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc_provider.dart';
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
                    PreViewRowButton(uuid, PreferitiBlocProvider.of(context)),
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
  PreferitiBloc bloc;
  PreViewRowButton(this.uuid, this.bloc);
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
              // TODO
            },
            icon: Icon(Icons.thumb_up),
            label: Text('Like'),
            textColor: Colors.greenAccent,
            highlightColor: Colors.greenAccent[100],
          ),
          FlatButton.icon(
            onPressed: () {
              // TODO
            },
            icon: Icon(Icons.thumb_down),
            label: Text('Dislike'),
            textColor: Colors.redAccent,
            highlightColor: Colors.redAccent[100],
          ),
          FlatButton.icon(
            onPressed: () async{
              SessionUser.pref.contains(widget.uuid)
                  ?widget.bloc.removeInFavourite(widget.uuid)
                  :widget.bloc.addInFavourite(widget.uuid);
            },
            icon: SessionUser.pref.contains(widget.uuid)?Icon(Icons.favorite):Icon(Icons.favorite_border),
            label: Text('Save'),
            textColor: Colors.blueAccent,
            highlightColor: Colors.blueAccent[100],
          ),
        ]);
  }
}
