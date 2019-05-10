import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc_provider.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_bloc_provider.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:share/share.dart';
import 'package:univer_city_app_1_1/elements/session_user.dart';

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
                    FutureBuilder(
                      future: HttpHandler.getLike(uuid) ,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return InfoRow('Like', '${snapshot.data}');
                          }
                          return InfoRow('Like', '...');
                        }),
                    FutureBuilder(
                        future: HttpHandler.getDislike(uuid) ,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return InfoRow('Dislike', '${snapshot.data}');
                          }
                          return InfoRow('Dislike', '...');
                        }),
                    //InfoRow('Rank', 'todo'),
                    //InfoRow('Downloads', 'todo'),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.feedback),
                      title: Text('Segnala'),
                      onTap: () {dialogSegnala(context);},
                      dense: true,
                    ),
                    ListTile(
                      leading: Icon(Icons.local_offer),
                      title: Text('Aiutaci con i tag'),
                      onTap: () {dialogSendTag(context, uuid);},
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
                        Share.share('Dai un occhiata a $titolo, lo trovi qui: ${HttpHandler.urlDocument(uuid)}');
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
                      pdfLoadViewer(context, uuid);
                    },
                    icon: Icon(Icons.play_circle_outline, color: Colors.white,),
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
              HttpHandler.like(SessionUser.user, widget.uuid);
              ThemeBloc tBloc = ThemeBlocProvider.of(context);
              tBloc.scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Like inviato')));
              // TODO
            },
            icon: Icon(Icons.thumb_up),
            label: Text('Like'),
            textColor: Colors.greenAccent,
            highlightColor: Colors.greenAccent[100],
          ),
          FlatButton.icon(
            onPressed: () {
              HttpHandler.dislike(SessionUser.user, widget.uuid);
              ThemeBloc tBloc = ThemeBlocProvider.of(context);
              tBloc.scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Dislike inviato')));
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
              setState(() {});
            },
            icon: SessionUser.pref.contains(widget.uuid)?Icon(Icons.favorite):Icon(Icons.favorite_border),
            label: Text('Save'),
            textColor: Colors.blueAccent,
            highlightColor: Colors.blueAccent[100],
          ),
        ]);
  }
}

dialogSegnala (BuildContext context){
  Navigator.of(context).pop();
  showDialog(
      context: context,
      builder: (context){
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(title: Text('Documento illegibile'), onTap: (){showSnackBarReport(context);Navigator.of(context).pop();}),
              ListTile(title: Text('Argomenti errati'), onTap: (){showSnackBarReport(context);Navigator.of(context).pop();}),
              ListTile(title: Text('Titolo non valido'), onTap: (){showSnackBarReport(context);Navigator.of(context).pop();}),
              ListTile(title: Text('Contenuto blasfemo'), onTap: (){showSnackBarReport(context);Navigator.of(context).pop();}),
            ],
          ),
        );
      }
  );
}

dialogSendTag (BuildContext context,String docId){
  List<String> tags = [];
  //Navigator.of(context).pop();
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
            title: Text('Quali tag vuoi aggiungere ?'),
            content: Padding(padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                      onChanged:(val){tags = val.split(' ');},
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Tags',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)))
                  ),
                  FlatButton.icon(onPressed: ()async{
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    await Future.delayed(Duration(milliseconds: 50));
                    await HttpHandler.addDocumentTags(docId, tags);
                    showSnackBarSendTags(context);}, icon: Icon(Icons.add_circle_outline), label: Text('invia'))
                ],
              ),
            )
        );
      }
  );
}

///
/// funzione che mostra nello scaffold uno snackbar che indica che la
/// segnalazione è stata inviata
///
showSnackBarReport(context){
  // TODO send data
  ThemeBloc tBloc = ThemeBlocProvider.of(context);
  tBloc.scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Segnalazione inviata')));
}


///
/// funzione che mostra nello scaffold uno snackbar che indica che
/// i nuovi tag sono stati inviati
///
showSnackBarSendTags(context){
  // TODO send data
  ThemeBloc tBloc = ThemeBlocProvider.of(context);
  tBloc.scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Nuovi tags inviati grazie !')));
}