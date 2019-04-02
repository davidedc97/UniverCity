import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc.dart';
export 'package:univer_city_app_1_1/bloc/preferiti_bloc.dart';

class PreferitiBlocProvider extends InheritedWidget {
  final PreferitiBloc bloc;

  @override
  bool updateShouldNotify(_) => true;

  PreferitiBlocProvider({Key key, Widget child})
      : bloc = PreferitiBloc(),
        super(key: key, child: child){
    bloc.fetchData();
  }

  static PreferitiBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PreferitiBlocProvider)
    as PreferitiBlocProvider)
        .bloc;
  }
}