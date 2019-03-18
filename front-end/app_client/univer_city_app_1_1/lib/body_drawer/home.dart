import 'package:univer_city_app_1_1/elements/elements.dart';

class Home extends StatelessWidget {

  List<Document> _preferiti = <Document>[];

  List<Widget> _prFo = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            //Preferiti
              flex: 3,
              child: (_prFo.isNotEmpty)
                  ? ListView.builder(
                  itemCount: _prFo.length,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: TitleDivider('Preferiti'),
                        );
                      default:
                        return _prFo[index - 1];
                    }
                  })
                  : Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TitleDivider('Qui compariranno i tuoi preferiti'),
                ),
                Text(
                    'Dai ci saranno degli appunti alla tua altezza, salva qualcosa !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.grey,
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                      size: 150,
                    ))
              ]))
        ]);
  }
}
