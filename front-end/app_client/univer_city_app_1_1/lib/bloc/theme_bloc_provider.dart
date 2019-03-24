import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc.dart';
export 'package:univer_city_app_1_1/bloc/theme_bloc.dart';

class ThemeBlocProvider extends InheritedWidget {
  final ThemeBloc bloc;

  @override
  bool updateShouldNotify(_) => true;

  ThemeBlocProvider({Key key, Widget child})
      : bloc = ThemeBloc(),
        super(key: key, child: child);

  static ThemeBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ThemeBlocProvider)
    as ThemeBlocProvider)
        .bloc;
  }
}