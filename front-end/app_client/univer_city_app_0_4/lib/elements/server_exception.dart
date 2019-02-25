class ServerException implements Exception {
  //TODO sto andando a bere quindi mi devo sbrigare, sta classe la faccio domani
  String _message = " Error";
  int _statusCode = 666;

  ServerException(this._message, this._statusCode);

  ServerException.withCode(code){
    this._statusCode = code;
  }

  String get message => _message;
  int get statusCode => _statusCode;

  String toString(){
    return this.statusCode.toString() + this.message;
  }

}