import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/filtri_bloc_provider.dart';

class Filtri extends StatefulWidget {
  @override
  _FiltriState createState() => _FiltriState();
}

class _FiltriState extends State<Filtri> {

  final List<String> _f = <String>['Utente', 'Appunto', 'Mashup'];
  List<String> _filters = <String>[];

  List<String> get filtriAttivi => _filters;

  Iterable<Widget> get filter sync* {
    for (String filtro in _f) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          label: Text(filtro),
          selected: _filters.contains(filtro),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                if(_filters.length==1)_filters.removeLast();
                _filters.add(filtro);
              } else {
                _filters.removeWhere((String name) {
                  return name == filtro;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final FiltriBloc bloc = FiltriBlocProvider.of(context);
    bloc.onFiltriChanged(_filters.isEmpty?'':_filters[0]);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Wrap(
        children: filter.toList(),
      )],
    );
  }
}