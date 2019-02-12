import 'package:flutter/material.dart';
import 'main_bloc.dart';
export 'main_bloc.dart';

class BlocProvider extends InheritedWidget {
  final MainBloc bloc;

  BlocProvider({Key key, Widget child})
      : bloc = MainBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static MainBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider)
            as BlocProvider)
        .bloc;
  }
}
