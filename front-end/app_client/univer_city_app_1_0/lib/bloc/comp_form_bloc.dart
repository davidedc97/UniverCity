import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CompFormBloc{
  //############################################################################gestione home
  //############################################################################preferiti recenti
  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  final BehaviorSubject<String> _password = BehaviorSubject<String>();

  //getters allo stream
  Function(String) get onEmailChanged => _email.sink.add;
  Function(String) get onPasswordChanged => _password.sink.add;

  // Validators
  Observable<String> get email => _email.stream.transform(validateEmail);
  Observable<String> get password => _password.stream.transform(validatePassword);



  // per eliminare errore di dart perche gli stream
  // dovrebbero essere chiusi prima o poi
  dispose(){
    _email.close();
    _password.close();
  }
}

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

final StreamTransformer<String,String> validateEmail =
StreamTransformer<String,String>.fromHandlers(handleData: (email, sink){
  final RegExp emailExp = new RegExp(_kEmailRule);

  if (!emailExp.hasMatch(email) || email.isEmpty){
    sink.addError('Inserisci un email valida');
  } else {
    sink.add(email);
  }
});

const String _kPasswordRule = r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$";

final StreamTransformer<String,String> validatePassword =
StreamTransformer<String,String>.fromHandlers(handleData: (password, sink){
  final RegExp passwordExp = new RegExp(_kPasswordRule);

  if (!passwordExp.hasMatch(password) || password.isEmpty){
    sink.addError('min 8 char, lower and upper case number and special char');
  } else {
    sink.add(password);
  }
});
