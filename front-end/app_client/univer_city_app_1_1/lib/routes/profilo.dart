import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';

final docTest = [
  Document('Telecomunicazioni', 'Cuomo', '550e8400-e29b-41d4-a716-446655440000',
      'O'),
  Document('Architetture dei calcolatori', 'Ciciani',
      '550e8400-e29b-41d4-a716-446655440001', 'O'),
  Document('Reti dei calcolatori', 'Vitaletti',
      '550e8400-e29b-41d4-a716-446655440002', 'O'),
  Document('Sistemi di calcolo I', 'Demetrescu',
      '550e8400-e29b-41d4-a716-446655440003', 'O'),
  Document('Sistemi di calcolo II', 'Demetrescu',
      '550e8400-e29b-41d4-a716-446655440004', 'O'),
  Document('Teoria dei ststemi', 'Catardi',
      '550e8400-e29b-41d4-a716-446655440005', 'O'),
  Document('Fondamenti di automatica', 'Marchetti',
      '550e8400-e29b-41d4-a716-446655440006', 'O'),
  Document('Economia', 'Nastasi', '550e8400-e29b-41d4-a716-446655440007', 'O'),
  Document('Controlli automatici', 'Nardi',
      '550e8400-e29b-41d4-a716-446655440008', 'O'),
  Document('EoA', 'Nardi', '550e8400-e29b-41d4-a716-446655440009', 'O'),
  Document('Analisi I', 'Camilli', '550e8400-e29b-41d4-a716-446655440010', 'O'),
  Document(
      'Analisi II', 'Camilli II', '550e8400-e29b-41d4-a716-446655440011', 'O'),
  Document('Fisica', 'Sibilia', '550e8400-e29b-41d4-a716-446655440012', 'O'),
  Document('Probabilità e statistica', 'Toaldo',
      '550e8400-e29b-41d4-a716-446655440013', 'O'),
  Document('Sicurezza Informatica', 'Franco',
      '550e8400-e29b-41d4-a716-446655440014', 'O'),
  Document('Fodamenti di informatica', 'Shaerf',
      '550e8400-e29b-41d4-a716-446655440015', 'O'),
  Document('Algoritmi e strutture dati', 'D\'amore',
      '550e8400-e29b-41d4-a716-446655440016', 'O'),
  Document('Proggettazione software', 'de giacomo',
      '550e8400-e29b-41d4-a716-446655440017', 'O'),
];

class Profilo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(children: <Widget>[
        Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4.0,
                      color: Colors.black,
                      offset: Offset(0.0, 0.0))
                ],
                gradient: LinearGradient(colors: [
                  Color(0xffd95a41),
                  Color(0xffc02641),
                ])),
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 8,
                    top: 16,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop())),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new NetworkImage(
                                    'https://scontent-fco1-1.xx.fbcdn.net/v/t1.0-9/15085656_1600112780014351_6901231904753481170_n.jpg?_nc_cat=105&_nc_ht=scontent-fco1-1.xx&oh=f671e3bbc24830ed233fa6d10d76acd9&oe=5CDA0C93'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(new Radius.circular(150.0)),
                              border: new Border.all(
                                color: Colors.white,
                                width: 4.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'adm_Davide',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'Stundente di ing, informatica',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ],
            )),

        ///
        ///
        /// Fine header
        ///
        ///
        Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Livello'),
                  leading: Text(
                    '1',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                LinearProgressIndicator(
                  value: 0.1,
                  backgroundColor: Color(0x77d95a41),
                )
              ],
            ),
          ),
        ),

        ///
        ///
        /// Bio
        ///
        ///
        Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Biografia'),
                  leading: Icon(Icons.book),
                  subtitle: Text(
                      '''\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
                  '''),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            color: Colors.white,
            child: Builder(builder: (context){
              List<Widget> lista = List();
              for(var i = 0; i<docTest.length; i++){
                lista.add(ListTile(
                  title: Text(docTest[i].title),
                  leading: Icon(Icons.description),
                ));
                return Column(
                  children: lista
                );
              }
            })

          ),
        )
      ]),
    );
  }
}
