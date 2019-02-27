/*
** MANCA GESTIONE MESSAGGI DI RITORNO. OBIETTIVO DI IMPLEMENTAZIONE: LUNEDì 25/ MARTEDì 26
** CODICE 200 {
**      LOGIN E REGISTRAZIONE = OK
** }
**     
** CODICE 400 {
**      LOGIN E REGISTRAZIONE = USER NOT FOUND
** }
*/

const express = require("express");
const app = express();

const bodyP = require("body-parser");
app.use(bodyP.urlencoded());

var mysql = require("mysql");

var connection = mysql.createConnection({
    host: "127.0.0.1",
    user: "root",
    password: "dinamik",
    port: 3306,
    database: "userdb"
})

connection.connect(function(err){
    if(err) throw err;
    console.log(err);
})

function DbManager_addUser(ur, pr){
    var control = 1;
    var username = ur;
    var pass = pr;
    console.log("dati letti" + " " + username + " " + pass);
    var query = "INSERT INTO user (username,pass) VALUES ?";
    var values = [
        [username, pass]
    ];
    connection.query(query, [values], function(err, res){
        if (err) throw err;
    })
}

function DbManager_searchUser(ul, pl){
    var control;
    var username = ul;
    var pass = pl;
    console.log("dati letti" + " " + username + " " + pass);
    var query = "SELECT * FROM user WHERE username = ?";
    var user = [
        [username]
    ];
    connection.query(query, [user], function(err, res){
        if (err) throw err;
    })
}

app.get("/", function(req,res){
        res.sendFile(__dirname + "/index.html");
        //res.sendStatus(200);
    })

app.post("/", function(req, res){
        var control;
        console.log("######################");
        console.log("# Richiesta ricevuta #");
        console.log("######################");
    
        if (req.body.ur){   
            var ur = req.body.ur;
            var pr = req.body.pr;
            console.log("Richiesta di Registrazione");
            console.log("Invio dati: ");
            console.log("User:" + ur);
            console.log("Pass: " + pr);
            control = DbManager_addUser(ur,pr);
            console.log("control on registration = " + control);
        }

        if (req.body.ul){
            var ul = req.body.ul;
            var pl = req.body.pl;
            console.log("Richiesta di LogIN");
            console.log("Invio dati: ");
            console.log("User:" + ul);
            console.log("Pass: " + pl);
            control = DbManager_searchUser(ul,pl);
            console.log("control on login = " + control);
        }
    })

app.get("/",function(req, res){
        console.log("terminated");
    })


var server = app.listen(8080, "127.0.0.1", function(){
    console.log("Server started");
})