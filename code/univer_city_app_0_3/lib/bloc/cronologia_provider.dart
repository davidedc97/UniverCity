import 'package:flutter/material.dart';
import 'cronologia_bloc.dart';
export 'cronologia_bloc.dart';

class CronologiaProvider extends InheritedWidget {
  final CronologiaBloc bloc;

  CronologiaProvider({Key key, Widget child})
      : bloc = CronologiaBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CronologiaBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CronologiaProvider)
    as CronologiaProvider)
        .bloc;
  }
}