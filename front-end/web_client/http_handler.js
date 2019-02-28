//import ;  decomment when others put the correct link

static function sendFormRegistration(user, name, surname, email, pw, faculty, university){
    var httpRequest = new XMLHttpRequest();
    var body = {"username": user, "name": name, "surname": surname, "email": email, "pass": pw, "faculty": faculty, "university":university};

    //httpRequest.open("POST", "http://www.porcaccioiltuodio.mam", true);
    httpRequest.onreadystatechange = function(){
        if(httpRequest.readyState == 4 /*&& httpRequest.status == 200*/){
            body = JSON.parse(this.responseText);
            //return 1;
        }
    };

    httpRequest.open("POST", "http://www.porcaccioiltuodio.mam", true);
    httpRequest.send(body);

    if(httpRequest.status == 200)
        return 1; //OK

    if(httpRequest.status == 400)
        return -1; //bad request

    if(httpRequest.status == 500)
    return -2; //internal server error

    else  
        alert("Errore" + xhr.status + ":" + xhr.statusText);
}

static function validateLogin(user, pw){
    var httpRequest = new XMLHttpRequest();
    var body = {"username": user, "pass": pw};

    httpRequest.onreadystatechange = function () {
        if(httpRequest.readyState == 4)
            body = JSON.parse(this.responseText);
    };

    httpRequest.open("POST", "http://www.porcaccioiltuodio.mam", true);
    httpRequest.send(body);

    if(httpRequest.status == 200)
        return 1;
    
    if(httpRequest.status == 400)
        return -1;
    
    if(httpRequest.status == 500)
        return -2;

    else
        alert("Errore" + xhr.status + ":" + xhr.statusText);
}

static function getMyUserById(userId){
    var httpRequest = new XMLHttpRequest();

    httpRequest.onreadystatechange = function() {
       // if(httpRequest.readyState == 4)
    }
    httpRequest.open("GET", "http://www.porcaccioiltuodio.mam", true);
    httpRequest.send();

    if(httpRequest.status == 200)
        return JSON.stringify(/*identita dell user*/);
}

static function getOtherUserById(userId){
    var httpRequest = new XMLHttpRequest();

    httpRequest.onreadystatechange = function() {
       // if(httpRequest.readyState == 4)
    }
    httpRequest.open("GET", "http://www.porcaccioiltuodio.mam", true);
    httpRequest.send();

    if(httpRequest.status == 200)
        return JSON.stringify(/*identita dell user*/);
}

/*  ##### GESTIONE DOCUMENTI #####*/ 

static function uploadDocument(title, type,  path){
    var uri = decodeURI("http://www.porcaccioiltuodio.mam" + "document"); //insert from import
    //TODO
}

static function getDocumentById(docId){
    var httpRequest = new XMLHttpRequest();

    httpRequest.onreadystatechange = function(){
        //if(httpRequest.readyState == 4)
            //return JSON.stringify(docId);
    };

    httpRequest.open("GET", "http://www.porcaccioiltuodio.mam", true );
    httpRequest.send();

    if(httpRequest.status == 200)
        return JSON.stringify(docId);
}