function CheckPassword() { 
    pw=document.getElementById("psw").value;
    var decimal =  /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;

    if(pw.match(decimal)) { 
        alert('Correct, try another...')
        return true;
    }
    else{ 
        alert('Wrong...!')
        return false;
    }
} 