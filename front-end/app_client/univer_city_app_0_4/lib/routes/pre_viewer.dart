import 'package:flutter/material.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:flutter_pdf_renderer/flutter_pdf_renderer.dart';

String assetPath = 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf';

viewerPdfByUuid(BuildContext context, String title, String uuid) {
  return MaterialPageRoute(
      settings: new RouteSettings(
        name: '/viewer',
        isInitialRoute: false,
      ),
      builder: (BuildContext context) {
        return DocDialog();
      });
}



class DocDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        child: SliverFab(
          floatingWidget: FloatingActionButton(
            onPressed: () => debugPrint('fab'),
            child: Icon(Icons.add),
          ),
          floatingPosition: FloatingPosition(right: 16),
          expandedHeight: 256.0,
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: 256.0,
              pinned: true,
              flexibleSpace: new FlexibleSpaceBar(
                title: new Text("SliverFab Example"),
                background: new Image.asset(
                  "img.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(
                new List.generate(
                  30,
                      (int index) =>
                  new ListTile(title: new Text("Item $index")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
