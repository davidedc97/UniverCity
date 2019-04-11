import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/filtri_bloc_provider.dart';

class Filtri extends StatefulWidget {
  FiltriBloc bloc;
  Filtri(this.bloc);
  @override
  _FiltriState createState() => _FiltriState();
}

class _FiltriState extends State<Filtri> {
  final List<String> _f = <String>[
    'Utenti',
    'Appunti & Mashups',
    'Appunti',
    'Mashups'
  ];
  final List<IconData> _i = <IconData>[
    Icons.account_circle,
    Icons.all_inclusive,
    Icons.description,
    Icons.art_track
  ];


  PageController _controller =
      PageController(initialPage: 1, keepPage: true, viewportFraction: 0.65);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.bloc.onFiltriChanged(1);
  }
  @override
  Widget build(BuildContext context) {
    final FiltriBloc bloc = FiltriBlocProvider.of(context);
    return PageView.builder(
      onPageChanged: bloc.onFiltriChanged,
      itemCount: _f.length,
      controller: _controller,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Container(
            decoration: BoxDecoration(color: Theme.of(context).accentColor,borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(_i[i], color: Colors.black,), SizedBox(width: 18,) ,Text(_f[i],style: TextStyle(color: Colors.black),)],
            ),
          ),
        );
      },
    );
  }
}
