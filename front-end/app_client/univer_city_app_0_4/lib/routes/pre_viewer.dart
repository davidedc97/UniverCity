import 'package:flutter/material.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

String assetPath = 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf';

Widget buildDocDialog(BuildContext context, String title, String uuid) {
  return Dialog(
    child: Container(
      child: SliverFab(
        floatingPosition: FloatingPosition(top: 0, left: 32, right: 32),
        floatingWidget: FloatingActionButton.extended(
          //BRUTTINO FORSE
          //shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
          onPressed: () => PdfViewer.loadAsset(assetPath),
          label: Text('Read'),
          icon: Icon(Icons.play_circle_outline),
        ),
        expandedHeight: 182.0,
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: 182.0,
            pinned: false,
            flexibleSpace: new FlexibleSpaceBar(

                ///
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
