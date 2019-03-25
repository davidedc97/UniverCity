const express = require("express");
const app = express();

const bodyP = require("body-parser");
app.use(bodyP.urlencoded());

var Pool = require('pg').Pool;

var AmazonCognitoIdentity = require('amazon-cognito-identity-js');
var CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool;
var AWS = require('aws-sdk');
var request = require('request');
var jwkToPem = require('jwk-to-pem');
var jwt = require('jsonwebtoken');
var crypto = require('crypto');
global.fetch = require('node-fetch');

var username = null;
var name = null;
var surname = null;
var email = null;
var pass = null;
var faculty = null;
var university = null;
var token = null;
var error = null;
var result = null;
<<<<<<< HEAD
var xp = null;
var bio = null;
var docUp = null;
var mashup = null;
var img = null;
=======
var verCode = null;
var newPassword = null;
>>>>>>> 4d12008b7da8b739b79793fe0d9421d91adcc8f6

/*
** ########################
** # SERVER CONFIGURATION #
** ########################
*/

const psql = new Pool ({
    host: 'metadata.czzhwg1jheui.eu-west-1.rds.amazonaws.com',
    user: 'univercity',
    password: '',
    database: 'metadata',
    port: 5432
})

var server = app.listen(8080, "127.0.0.1", function(){
    console.log("Server started");
})

const poolData = {
    UserPoolId: "eu-west-2_TBU678aQA",
    ClientId: "<ClientAppId>"
};

const pool_region= "eu-west-2";

const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

/*
** ###################
** # CLIENT WRAPPING #
** ###################
*/

// debugging req

/*app.get("/", function(req,res){
    res.sendStatus(200);
})*/

app.post("/userReg", function(req, res){
    username = req.body.username;
    name = req.body.name;
    surname = req.body.surname;
    email = req.body.email;
    pass = req.body.pass;
    faculty = req.body.faculty;
    university = req.body.university;
    
    var control = SignUp();

    if (control == null) res.sendStatus(400).statusMessage("User already exist");
    else {
        res.sendStatus(200);
    }
})

app.post("/userLog", function(req, res){
    username = req.body.username;
    pass = req.body.pass;

    var control = SignIn();

    if (control == 0) res.sendStatus(200).statusMessage(token);
    else {
        res.sendStatus(400);
    }
})

app.post("/resetPass", function(err, res){
    pass = req.body.pass;

    var response = resetPass();

    if (response == 0) res.sendStatus(200);
    else{
        res.sendStatus(400);
    }
})

app.get("/userData", function(req,res){
    username = req.body.username;

    psql.query("SELECT * from utilitator where username = $1", [username], function(err, result){
        if(err) throw err;
        else {
            res.sendStatus(200).json(result.rows);
        }
    })
})

app.get("/userImg", function(req,res){
    username = req.body.username;

    psql.query("SELECT image from utilitator where username = $1", [username], function(err, result){
        if(err) throw err;
        else {
            res.sendStatus(200).json(result.rows);
        }
    })
})

app.put("/userImg", function(req,res){
    username = req.body.username;
    img = req.body.file;

    psql.query("update image value ($1) from utilitator where username = $2", [img,username], function(err, result){
        if(err) throw err;
        else {
            res.sendStatus(200).json(result.rows);
        }
    })
})

app.put("/userExperience", function(req,res){
    username = req.body.username;
    xp = req.body.experience;

    psql.query("update xp value ($1) from utilitator where username = $2", [xp,username], function(err, result){
        if(err) throw err;
        else {
            res.sendStatus(200).json(result.rows);
        }
    })
})

app.put("/userBio", function(req,res){
    username = req.body.username;
    bio = req.body.bio;

    psql.query("update bio value ($1) from utilitator where username = $2", [bio,username], function(err, result){
        if(err) throw err;
        else {
            res.sendStatus(200).json(result.rows);
        }
    })
})

app.post("/resetAux", function(err, res){
    username = req.body.username;
    verCode = req.body.verCode;
    newPassword = req.body.newPassword;

    var response = confirmPassword();

    if (response == 0) res.sendStatus(200);
    else{
        res.sendStatus(400);
    }
})

// getOtherUserById and getMyUserById MISSING

/*
** ########################
** # REGISTRATION PROCESS #
** ########################
*/

function SignUp(){

    var pwd = username + Date();
    var id = crypto.createHash('sha256').update().digest;

    var attList = [];
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "id", Value: id}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "name", Value: name}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "surname", Value: surname}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "email", Value: email}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "faculty", Value: faculty}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "university", Value: university}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "preferrred_username", Value: username}));

    userPool.signUp(username, pass, attList, null, function(err, res){
        if(err){
            return err.name;
        }
        var cognitoUser = res.user;
        return cognitoUser.getUsername();
    })

    pool.query("INSERT INTO utilitator (username,favourite,bio,xp,uploaded,image) VALUES ($1, $2, $3, $4, $5, $6)",[username, null, null, 0, null, null], function(err, res){
        if (err) throw err;
    })
}

/*
** #################
** # LOGIN PROCESS #
** #################
*/

function SignIn(){
    var autenticationValue = new AmazonCognitoIdentity.AuthenticationDetails({
        Username: username,
        Password: pass
    })

    var userData = {
        Username: username,
        Pool: userPool,
        Data: userData
    }

    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.authenticateUser(autenticationValue, {
        onSuccess: function(res) {
            token = res.getAccessToken().getJwtToken();
        },
        onFailure: function(err) {
            error = err;
        },
    });

    if (token != null && error == null) return 0;
    else if (token == null && error != null) return 1;
}

/*
** ##################
** # RESET PASSWORD #
** ##################
*/

// still in development

function resetPassword(username, newPass, verificationCode) {

    cognitoUser = new AWSCognito.CognitoUser({
        Username: username,
        Pool: userPool
    });

    cognitoUser.forgotPassword({
        onSuccess: function(result) {
            console.log("OK zi");
            resolve(0);
        },
        onFailure: function(err) {
            console.log("eh no porcodio");
            reject(err);
        }
    });
} 
 
function confirmPassword() {

    cognitoUser = new AWSCognito.CognitoUser({
        Username: username,
        Pool: userPool
    });

    return new Promise((resolve, reject) => {
        cognitoUser.confirmPassword(verCode, newPassword, {
            onFailure(err) {
                return(err);
            },
            onSuccess() {
                return(0);
            },
        });
    });
}
