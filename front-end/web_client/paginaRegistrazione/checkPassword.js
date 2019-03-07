<<<<<<< HEAD
function checkPassword() { 

 //  var decimal =  /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8+}$/;
    var decimal = /(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%\^&])(?=.*[A-Z]).{8,}/;
    var pw = document.registra.pass.value;

   /* if(pw.length < 8){
        alert("Password must be longer than 6 characters");
        return false;
    }*/

    if( !document.registra.pass.value.match(decimal)) { 
        //alert('Correct, try another...');
        alert("Password must contain at least a special character, a number, a capital letter and must be longer than 8 characters");
=======
function CheckPassword() { 
    pw=document.getElementById("psw").value;
    var decimal =  /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;

    if(pw.match(decimal)) { 
        alert('Correct, try another...')
        return true;
    }
    else{ 
        alert('Wrong...!')
>>>>>>> c2cbe9d7f4c766d958697145b95deabeda2b6d4c
        return false;
    }
    return true;
} 