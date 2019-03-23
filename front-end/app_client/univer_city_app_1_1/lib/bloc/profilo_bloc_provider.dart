import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/profilo_bloc.dart';
export 'package:univer_city_app_1_1/bloc/profilo_bloc.dart';

class ProfiloBlocProvider extends InheritedWidget {
  final ProfiloBloc bloc;

  ProfiloBlocProvider({Key key, Widget child}): bloc = ProfiloBloc(),super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static ProfiloBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProfiloBlocProvider)
    as ProfiloBlocProvider)
        .bloc;
  }

}