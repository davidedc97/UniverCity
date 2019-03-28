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
];
final mashTest = [
  Document('Controlli automatici', 'Nardi',
      '550e8400-e29b-41d4-a716-446655440008', 'M'),
  Document('EoA', 'Nardi', '550e8400-e29b-41d4-a716-446655440009', 'M'),
  Document('Analisi I', 'Camilli', '550e8400-e29b-41d4-a716-446655440010', 'M'),
  Document(
      'Analisi II', 'Camilli II', '550e8400-e29b-41d4-a716-446655440011', 'M'),
  Document('Fisica', 'Sibilia', '550e8400-e29b-41d4-a716-446655440012', 'M'),
  Document('Probabilità e statistica', 'Toaldo',
      '550e8400-e29b-41d4-a716-446655440013', 'M'),
  Document('Sicurezza Informatica', 'Franco',
      '550e8400-e29b-41d4-a716-446655440014', 'M'),
  Document('Fodamenti di informatica', 'Shaerf',
      '550e8400-e29b-41d4-a716-446655440015', 'M'),
  Document('Algoritmi e strutture dati', 'D\'amore',
      '550e8400-e29b-41d4-a716-446655440016', 'M'),
  Document('Proggettazione software', 'de giacomo',
      '550e8400-e29b-41d4-a716-446655440017', 'M'),
];

class Profilo extends StatelessWidget {
  final String uuid = '550e8400-e29b-41d4-a716-446655440017',
      userName = 'userName';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(userName,
                style: TextStyle(
                  fontSize: 16.0,
                )),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: <Widget>[
                  HeadProfile(SessionUser().user ?? 'UserName', 'ingMerendine', 'https://scontent-fco1-1.xx.fbcdn.net/v/t1.0-9/31674176_1973734962646218_3870591241158656000_n.jpg?_nc_cat=103&_nc_ht=scontent-fco1-1.xx&oh=912ceebe8084f258395a3dca2caf6f12&oe=5D23DF90'),
                  LevelBar(33670),
                  ProfileBio('\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
                  ShowNoteClp('Appunti caricati',docTest),
                  ShowNoteClp('Mashup creati',mashTest),
                ],
              );
            },
            childCount: 1,
          ),
        )
      ],
    ));
  }
}

