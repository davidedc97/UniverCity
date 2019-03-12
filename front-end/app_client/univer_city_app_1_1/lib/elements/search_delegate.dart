import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class DocSearch extends SearchDelegate<Document> {
  final docTest = [
    Document('Telecomunicazioni', 'Cuomo', '550e8400-e29b-41d4-a716-446655440000', 'O'),
    Document('Architetture dei calcolatori', 'Ciciani', '550e8400-e29b-41d4-a716-446655440001', 'O'),
    Document('Reti dei calcolatori', 'Vitaletti', '550e8400-e29b-41d4-a716-446655440002', 'O'),
    Document('Sistemi di calcolo I', 'Demetrescu', '550e8400-e29b-41d4-a716-446655440003', 'O'),
    Document('Sistemi di calcolo II', 'Demetrescu', '550e8400-e29b-41d4-a716-446655440004', 'O'),
    Document('Teoria dei ststemi', 'Catardi', '550e8400-e29b-41d4-a716-446655440005', 'O'),
    Document('Fondamenti di automatica', 'Marchetti', '550e8400-e29b-41d4-a716-446655440006', 'O'),
    Document('Economia', 'Nastasi', '550e8400-e29b-41d4-a716-446655440007', 'O'),
    Document('Controlli automatici', 'Nardi', '550e8400-e29b-41d4-a716-446655440008', 'O'),
    Document('EoA', 'Nardi', '550e8400-e29b-41d4-a716-446655440009', 'O'),
    Document('Analisi I', 'Camilli', '550e8400-e29b-41d4-a716-446655440010', 'O'),
    Document('Analisi II', 'Camilli II', '550e8400-e29b-41d4-a716-446655440011', 'O'),
    Document('Fisica', 'Sibilia', '550e8400-e29b-41d4-a716-446655440012', 'O'),
    Document('Probabilità e statistica', 'Toaldo', '550e8400-e29b-41d4-a716-446655440013', 'O'),
    Document('Sicurezza Informatica', 'Franco', '550e8400-e29b-41d4-a716-446655440014', 'O'),
    Document('Fodamenti di informatica', 'Shaerf', '550e8400-e29b-41d4-a716-446655440015', 'O'),
    Document('Algoritmi e strutture dati', 'D\'amore', '550e8400-e29b-41d4-a716-446655440016', 'O'),
    Document('Proggettazione software', 'de giacomo', '550e8400-e29b-41d4-a716-446655440017', 'O'),
  ];

  final recentDocs = [
    Document('Controlli automatici', 'Nardi','550e8400-e29b-41d4-a716-446655440008', 'O'),
    Document('EoA', 'Nardi', '550e8400-e29b-41d4-a716-446655440009', 'O'),
    Document('Analisi I', 'Camilli', '550e8400-e29b-41d4-a716-446655440010', 'O'),
    Document('Analisi II', 'Camilli II', '550e8400-e29b-41d4-a716-446655440011', 'O'),
    Document('Fisica', 'Sibilia', '550e8400-e29b-41d4-a716-446655440012', 'O'),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //  action for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  leading icon
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show result based from selections
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when search for anythings
    final risultatiList = query.isEmpty?recentDocs:docTest;

    return ListView.builder(
      itemBuilder: (context, index)=>ListTile(
        leading: Icon(Icons.description),
        title: Text(docTest[index].title),
      ),
      itemCount: risultatiList.length,
    );
  }
}