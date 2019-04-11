import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

class Intro extends StatelessWidget {

  final pages = [
    PageViewModel(
        pageColor: Color(0xffc02641),
        bubble: Icon(Icons.description),
        body: Text(
          '''Basta cercare su diversi drive prima di trovare un appunto decente. Cerca, gratuitamente, in un unica app tutti gli appunti, di qualsiasi facoltà, caricati da studenti''',
          style: TextStyle(fontSize: 18),
        ),
        title: Text(
          'Un tool per tutto',
        ),
        textStyle: TextStyle(fontFamily: 'Bahnschrift', color: Colors.white),
        mainImage: Image.asset(
          'assets/img/un-tool-2.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: Colors.blueGrey[800],
      bubble: Icon(Icons.art_track),
      body: Text(
        '''Crea un documento con le migliori parti degli appunti che troverai, per avere un unico documento con tutto quello che ti serve. Provalo nella nostra applicazione web! ''',
        style: TextStyle(fontSize: 18,color: Colors.white),
      ),
      title: Text('Mashup',style: TextStyle(color: Colors.white),),
      mainImage: Image.asset(
        'assets/img/mash.png',
        height: 200.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'Bahnschrift', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) =>
          IntroViewsFlutter(
            pages,
            onTapDoneButton: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
            },
            pageButtonTextStyles: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ), //IntroViewsFlutter
    );
  }
}
