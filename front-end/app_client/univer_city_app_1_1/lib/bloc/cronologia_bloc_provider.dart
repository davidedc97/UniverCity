import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_bloc.dart';
export 'package:univer_city_app_1_1/bloc/cronologia_bloc.dart';

class CronologiaBlocProvider extends InheritedWidget {
  final CronologiaBloc bloc;

  @override
  bool updateShouldNotify(_) => true;

  CronologiaBlocProvider({Key key, Widget child})
      : bloc = CronologiaBloc(),
        super(key: key, child: child){
      /// All the entries are loaded, we can fill in the [favoritesBloc]...
      bloc.init();
  }

  static CronologiaBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CronologiaBlocProvider)
    as CronologiaBlocProvider)
        .bloc;
  }
}