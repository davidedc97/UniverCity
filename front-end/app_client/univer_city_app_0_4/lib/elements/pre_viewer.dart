import 'package:flutter/material.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:univer_city_app_0_4/elements/info_row.dart';
import 'package:univer_city_app_0_4/elements/pdf_viewer_func.dart';
import 'dart:typed_data';

String assetPath = 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf';
String uuid2 = "68c5e7d6-3c19-11e9-b210-d663bd873d93";
Uint8List d;
///
/// buildDocDialog(BuildContext context, String title, String uuid);
/// è una funzione che a partire dal contesti il titolo e l'uuid
/// di un documento restituisce un dialog con le info di un file
/// prima di passare al reader dalla ricerca offrendo la possibilità
/// di salvare tra i preferiti, mettere like scaricare etc ed avere (forse)
/// un anteprima del documento (da testare per la velocità nel rendering)
///
/// forse potrebbe sostituire il BottomSheetInfoFile ma da vedere
///

Widget buildDocDialog(BuildContext context, String title, String uuid) {
  return Dialog(
    child: Container(
      child: SliverFab(
        floatingPosition: FloatingPosition(top: 0, left: 32, right: 32),
        floatingWidget: FloatingActionButton.extended(
          //BRUTTINO FORSE
          //shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
          /**
          onPressed: ()async{
            debugPrint('loadingPdf');
            Uint8List res = await HttpHandler.getDocumentById(uuid2);
            //debugPrint(res.toString());
            debugPrint('fine getDocument');
            PdfViewer.loadBytes(res);
          },**///PDF VIEWER ##############
          onPressed: ()async{
            pdfFuncView(context, uuid);
          },
          backgroundColor: Color(0xFF393E46),
          label: Text('Read'),
          icon: Icon(Icons.play_circle_outline),
        ),
        expandedHeight: 182.0,
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: 182.0,
            pinned: false,
            flexibleSpace: new FlexibleSpaceBar(
              background: Image(image: AssetImage('assets/img/sfondo_login2.png'),fit: BoxFit.fitWidth,)
                ///
                /// spazio SilverAppBar
                /// da mettere o anteprima pdf o immagine bella
                ///
                ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(2, (int index) {
                return (index == 0)
                    ? SizedBox(
                        height: 32,
                      )
                    : Column(
                        children: <Widget>[
                          ListTile(
                              leading: Icon(Icons.info), title: Text(title)),
                          Divider(),
                          InfoRow('Proprietario', 'todo'),
                          InfoRow('Rank', 'todo'),
                          InfoRow('Downloads', 'todo'),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.content_copy),
                            title: Text('Copia Link'),
                            onTap: () => debugPrint('url'), //TODO copia link
                          ),
                          ListTile(
                            leading: Icon(Icons.file_download),
                            title: Text('Scarica'),
                            onTap: () => debugPrint(
                                'downloading $uuid'), //TODO DOWNLOAD UUID
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: <Widget>[
                              FlatButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.thumb_up),
                                  label: Text('Like'),textColor: Colors.greenAccent,),
                              FlatButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border),
                                  label: Text('Save'), textColor: Colors.redAccent,),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ],
                      );
              }),
            ),
          ),
        ],
      ),
    ),
  );
}
