
var express = require("express");
var app = express();

var bodyP = require("body-parser");
app.use(bodyP.urlencoded({estended: false}));

var mysql = require("mysql");

var connection = mysql.createConnection({
    host: "localhost",
    user: "isfet",
    password: ""
})

connection.connect(function(err){
    if(err) throw err;
    console.log("DB logged");
})

function DbManager(){
    connection.query("CREATE DATABASE UserDB", function(err, result){
        if(err) console.log(err);
    })

    connection.query("CREATE TABLE User (Username VARCHAR(255), name VARCHAR(255), surname VARCHAR(255), email VARCHAR(255), pass VARCHAR(255))", function(err, result){
        if(err) console.log(err);
    })
}

function DbManager_table(user, pass){

    connection.query("INSERT INTO User (name, surname) VALUES (user, pass)", function(err, result){
        if(err) console.log(err);
    })

    connection.query("SELECT * FROM User", function(err, result){
        if(err) console.log(err);
        console.log(result);
    })
}

app.route("/")

    .get(function(req,res){
        res.sendFile(__dirname + "/simple_we_page.html");
    })

    .post(function(req, res){
        console.log("Richiesta ricevuta");
        console.log("##################");
    
        if (req.body.ur){   
            var ur = req.body.ur;
            var pr = req.body.pr;
            console.log("Richiesta di Registrazione");
            console.log("Invio dati: ");
            console.log("User:" + ur);
            console.log("Pass: " + pr);
            //DbManager(ur,pr);
        }

        if (req.body.ul){
            var ul = req.body.ul;
            var pl = req.body.pl;
            console.log("Richiesta di LogIN");
            console.log("Invio dati: ");
            console.log("User:" + ul);
            console.log("Pass: " + pl);
            //DbManager(ul,pl);
        }
    })

    .get(function(req, res){
        console.log("terminated");
    })

var server = app.listen(1234, "127.0.0.1", function(){
    console.log("Started");
})
