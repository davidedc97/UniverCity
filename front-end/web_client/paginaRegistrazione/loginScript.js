function validaForm(){
  if (controllaPassword() == false){
      return false;
  }
  return true;
}
function controllaPassword(){
    if (document.registra.inputPassword.value != document.registra.controllaPassword.value){
        alert("Errore, password diverse");
        return false;
    }
    return true;
}
