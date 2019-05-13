import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/mash_bloc.dart';
export 'package:univer_city_app_1_1/bloc/mash_bloc.dart';

class MashupBlocProvider extends InheritedWidget {
  final MashupBloc bloc;

  @override
  bool updateShouldNotify(_) => true;

  MashupBlocProvider({Key key, Widget child})
      : bloc = MashupBloc(),
        super(key: key, child: child){
    print('init mash');
    bloc.init();
  }

  static MashupBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MashupBlocProvider)
    as MashupBlocProvider)
        .bloc;
  }
}