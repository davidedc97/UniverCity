import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/filtri_bloc.dart';
export 'package:univer_city_app_1_1/bloc/filtri_bloc.dart';

class FiltriBlocProvider extends InheritedWidget {
  final FiltriBloc bloc;

  FiltriBlocProvider({Key key, Widget child}): bloc = FiltriBloc(),super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static FiltriBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(FiltriBlocProvider)
    as FiltriBlocProvider)
        .bloc;
  }

}