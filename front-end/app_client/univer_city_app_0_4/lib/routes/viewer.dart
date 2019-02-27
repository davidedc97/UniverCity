import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

String assetPath = 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf';

viewerPdfByUuid(BuildContext context,String title, String uuid){


  return MaterialPageRoute(
    settings: new RouteSettings(
      name: '/viewer',
      isInitialRoute: false,
    ),
    builder: (BuildContext context) {
     return PDFViewerScaffoldAssets(
       assetsPath: assetPath,
       appBar: AppBar(
         title: Text(title),
         actions: <Widget>[
           IconButton(icon: Icon(Icons.thumb_up), onPressed: (){}),
           IconButton(icon: Icon(Icons.favorite_border), onPressed: (){}),
         ],
       ),
     );

    }
  );
}
