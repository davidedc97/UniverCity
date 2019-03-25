import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeBloc {
 final BehaviorSubject<int> _themeIndex = BehaviorSubject<int>();
  ThemeBloc(){
    SharedPreferences.getInstance().then((SharedPreferences tm){
      if(tm.getInt('themeIndex')==null){
        print('init to 0');
        _themeIndex.sink.add(0);

      }else{
        int storedValue = tm.getInt('themeIndex');
        _themeIndex.sink.add(storedValue);
        print('read to stored value ${tm.getInt('themeIndex')} storedbloc $storedValue');
      }
    });
  }

  Observable<int> get themeIndex => _themeIndex.stream;
  int get themeIndexValue => _themeIndex.value;
  Function get onChangedThemeIndex => _themeIndex.sink.add;

  bool get state => themeIndexValue==0;

  get firstColorGradient => state?Color(0xffd95a41):Color(0xfff2d16d);

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