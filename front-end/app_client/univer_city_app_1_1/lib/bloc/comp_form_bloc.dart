import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CompFormBloc{
  //############################################################################gestione home
  //############################################################################preferiti recenti
  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  final BehaviorSubject<String> _password = BehaviorSubject<String>();
  final BehaviorSubject<String> _userName = BehaviorSubject<String>();
  final BehaviorSubject<String> _nome = BehaviorSubject<String>();
  final BehaviorSubject<String> _cognome = BehaviorSubject<String>();
  final BehaviorSubject<String> _facolta = BehaviorSubject<String>();
  final BehaviorSubject<String> _universita = BehaviorSubject<String>();

  //getters allo stream
  Function(String) get onEmailChanged => _email.sink.add;
  Function(String) get onPasswordChanged => _password.sink.add;
  Function(String) get onUserNameChanged => _userName.sink.add;
  Function(String) get onNomeChanged => _nome.sink.add;
  Function(String) get onCognomeChanged => _cognome.sink.add;
  Function(String) get onFacoltaChanged => _facolta.sink.add;
  Function(String) get onUniversitaChanged => _universita.sink.add;

  // Validators
  Observable<String> get email => _email.stream.transform(validateEmail);
  Observable<String> get password => _password.stream.transform(validatePassword);
  Observable<String> get userName => _userName.stream.transform(validateUserName);
  Observable<String> get nome => _nome.stream.transform(validateNome);
  Observable<String> get cognome => _cognome.stream.transform(validateCognome);
  Observable<String> get facolta => _facolta.stream.transform(validateFacolta);
  Observable<String> get universita => _universita.stream.transform(validateUniversita);

  String get emailValue => _email.value;
  String get passwordValue => _password.value;
  String get userNameValue => _userName.value;
  String get nomeValue => _nome.value;
  String get cognomeValue => _cognome.value;
  String get facoltaValue => _facolta.value;
  String get universitaValue => _universita.value;



  // per eliminare errore di dart perche gli stream
  // dovrebbero essere chiusi prima o poi
  dispose(){
    _email.close();
    _password.close();
    _userName.close();
    _nome.close();
    _cognome.close();
    _facolta.close();
    _universita.close();
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

final StreamTransformer<String,String> validateUserName =
StreamTransformer<String,String>.fromHandlers(handleData: (userName, sink){

  if (userName.isEmpty){
    sink.addError('obbligatorio');
  } else {
    sink.add(userName);
  }
});

final StreamTransformer<String,String> validateNome =
StreamTransformer<String,String>.fromHandlers(handleData: (nome, sink){

  if (nome.isEmpty){
    sink.addError('obbligatorio');
  } else {
    sink.add(nome);
  }
});

final StreamTransformer<String,String> validateCognome =
StreamTransformer<String,String>.fromHandlers(handleData: (cognome, sink){

  if (cognome.isEmpty){
    sink.addError('obbligatorio');
  } else {
    sink.add(cognome);
  }
});

final StreamTransformer<String,String> validateFacolta =
StreamTransformer<String,String>.fromHandlers(handleData: (facolta, sink){

  if (facolta.isEmpty){
    sink.addError('obbligatorio');
  } else {
    sink.add(facolta);
  }
});

final StreamTransformer<String,String> validateUniversita =
StreamTransformer<String,String>.fromHandlers(handleData: (universita, sink){

  if (universita.isEmpty){
    sink.addError('obbligatorio');
  } else {
    sink.add(universita);
  }
});




