import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/upload_bloc.dart';
export 'package:univer_city_app_1_1/bloc/upload_bloc.dart';

class UploadBlocProvider extends InheritedWidget {
  final UploadBloc bloc;

  UploadBlocProvider({Key key, Widget child})
      : bloc = UploadBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static UploadBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UploadBlocProvider)
    as UploadBlocProvider)
        .bloc;
  }
}
