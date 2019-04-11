import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_search_bloc.dart';
export 'package:univer_city_app_1_1/bloc/cronologia_search_bloc.dart';

class CronologiaSearchBlocProvider extends InheritedWidget {
  final CronologiaSearchBloc bloc;

  @override
  bool updateShouldNotify(_) => true;

  CronologiaSearchBlocProvider({Key key, Widget child})
      : bloc = CronologiaSearchBloc(),
        super(key: key, child: child){
    /// All the entries are loaded, we can fill in the [favoritesBloc]...
    bloc.init();
  }

  static CronologiaSearchBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CronologiaSearchBlocProvider)
    as CronologiaSearchBlocProvider)
        .bloc;
  }
}