import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class UploadBloc {
  //############################################################################gestione home
  //############################################################################preferiti recenti
  final BehaviorSubject<String> _titolo = BehaviorSubject<String>();
  final BehaviorSubject<String> _tags = BehaviorSubject<String>();
  final BehaviorSubject<String> _path = BehaviorSubject<String>();

  //getters allo stream
  Function(String) get onTitoloChanged => _titolo.sink.add;
  Function(String) get onTagsChanged => _tags.sink.add;
  Function(String) get onPathChanged => _path.sink.add;

  // Validators
  Observable<String> get titolo => _titolo.stream.transform(validateTitolo);
  Observable<String> get tags => _tags.stream.transform(validateTags);
  Observable<String> get path => _path.stream;

  String get titoloValue => _titolo.value;
  String get tagsValue => _tags.value;
  String get pathValue => _path.value;


  // per eliminare errore di dart perche gli stream
  // dovrebbero essere chiusi prima o poi
  dispose() {
    _titolo.close();
    _tags.close();
    _path.close();
  }
}



final StreamTransformer<String, String> validateTitolo =
StreamTransformer<String, String>.fromHandlers(handleData: (titolo, sink) {

  if (titolo.isEmpty) {
    sink.addError('Inserisci un titolo');
  } else {
    sink.add(titolo);
  }
});

final StreamTransformer<String, String> validateTags =
StreamTransformer<String, String>.fromHandlers(
    handleData: (tags, sink) {

      if (tags.isEmpty) {
        sink.addError('inserisci i tags');
      } else {
        sink.add(tags);
      }
    });
