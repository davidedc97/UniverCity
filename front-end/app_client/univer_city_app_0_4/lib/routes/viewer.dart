
import 'package:flutter/material.dart';


String assetPath = 'assets/doc/Dispense_Reti_Benelli_Giambene.pdf';

viewerPdfByUuid(BuildContext context,String title, String uuid){

  String u = 'https://laeman87.files.wordpress.com/2013/06/telecomunicazioni.pdf';
  Uri ur = Uri(
    port: 80,
    scheme: 'https',
    host: 'laeman87.files.wordpress.com',
    path: '/2013/06/telecomunicazioni.pdf',
    queryParameters: {}
  );

  return MaterialPageRoute(
    settings: new RouteSettings(
      name: '/viewer',
      isInitialRoute: false,
    ),
    builder: (BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(title),
         actions: <Widget>[
           IconButton(icon: Icon(Icons.thumb_up), onPressed: (){}),
           IconButton(icon: Icon(Icons.favorite_border), onPressed: (){}),
         ],
       ),
       body: Container(),
     );
    });
}

