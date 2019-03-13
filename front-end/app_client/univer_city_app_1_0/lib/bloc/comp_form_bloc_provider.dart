import 'package:flutter/material.dart';
import 'package:univer_city_app_1_0/bloc/comp_form_bloc.dart';
export 'package:univer_city_app_1_0/bloc/comp_form_bloc.dart';

class CompFormBlocProvider extends InheritedWidget {
  final CompFormBloc bloc;

  CompFormBlocProvider({Key key, Widget child})
      : bloc = CompFormBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CompFormBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CompFormBlocProvider)
    as CompFormBlocProvider)
        .bloc;
  }
}
