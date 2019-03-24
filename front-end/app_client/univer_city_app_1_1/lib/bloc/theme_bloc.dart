import 'package:rxdart/rxdart.dart';

class ThemeBloc {

  final BehaviorSubject<int> _themeIndex = BehaviorSubject<int>(seedValue: 0);

  Observable<int> get themeIndex => _themeIndex.stream;
  int get themeIndexValue => _themeIndex.value;
  Function get onChangedThemeIndex => _themeIndex.sink.add;

  change(){
    if(themeIndexValue==0){
      onChangedThemeIndex(1);
    }else{
      onChangedThemeIndex(0);
    }
  }

  dispose(){
    _themeIndex.close();
  }
}