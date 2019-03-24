import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeBloc {
 static int storedValue;

  ThemeBloc(){
    SharedPreferences.getInstance().then((SharedPreferences tm){
      if(tm.getInt('themeIndex')==null){
        print('init to 0');
        storedValue = 0;
      }else{
        storedValue = tm.getInt('themeIndex');
        print('read to stored value ${tm.getInt('themeIndex')} storedbloc $storedValue');
      }
    });
  }

  final BehaviorSubject<int> _themeIndex = BehaviorSubject<int>(seedValue: (storedValue==0)?0:1);

  Observable<int> get themeIndex => _themeIndex.stream;
  int get themeIndexValue => _themeIndex.value;
  Function get onChangedThemeIndex => _themeIndex.sink.add;

  bool get state => themeIndexValue==0;

  get firstColorGradient => state?Color(0xffd95a41):Color(0xff5ba8a0);

  change(){
    if(themeIndexValue==0){
      onChangedThemeIndex(1);
      print('saving');
      _save(1);
      print('saved');
    }else{
      onChangedThemeIndex(0);
      print('saving');
      _save(0);
      print('saved');
    }

  }

  _save(int value){
    SharedPreferences.getInstance().then((SharedPreferences tm){
      print('saving2');
      tm.setInt('themeIndex', themeIndexValue);
      print('saved2');
    });
  }

  dispose(){
    _themeIndex.close();
  }
}