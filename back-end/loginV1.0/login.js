
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
    var username = ur;
    var pass = pr;
    console.log("dati letti" + " " + username + " " + pass);
    var control = 0; 
    connection.query("INSERT INTO user (username,pass) VALUES (username, pass)", function(err, result){
        if(err) throw err;
        console.log(err);
        control = 1;
        console.log(result);
    })
    return control;
}

function DbManager_searchUser(ul, pl){
    var username = ul;
    var pass = pl;
    connection.query("SELECT username FROM user", function(err, result){
        if(err) throw err;
        console.log(err);
        control = 1;
    })
    return control;
}

app.get("/", function(req,res){
        res.sendFile(__dirname + "/index.html");
        //res.sendStatus(200);
    })

app.post("/", function(req, res){
        var control;
        console.log("##################");
        console.log("Richiesta ricevuta");
        console.log("##################");
    
        if (req.body.ur){   
            var ur = req.body.ur;
            var pr = req.body.pr;
            console.log("Richiesta di Registrazione");
            console.log("Invio dati: ");
            console.log("User:" + ur);
            console.log("Pass: " + pr);
            control = DbManager_addUser(ur,pr);
            console.log("control = " + control);
        }

        if (req.body.ul){
            var ul = req.body.ul;
            var pl = req.body.pl;
            console.log("Richiesta di LogIN");
            console.log("Invio dati: ");
            console.log("User:" + ul);
            console.log("Pass: " + pl);
            control = DbManager_searchUser(ul,pl);
            if (control == 1) res.sendStatus(400);
            else res.sendStatus(200);
            control = 0;
        }
    })

app.get("/",function(req, res){
        console.log("terminated");
    })


var server = app.listen(8080, "127.0.0.1", function(){
    console.log("Server started");
})