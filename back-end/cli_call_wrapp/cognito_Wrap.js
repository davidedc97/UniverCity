const express = require("express");
const app = express();

const bodyP = require("body-parser");
app.use(bodyP.urlencoded());

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

/*
** ########################
** # SERVER CONFIGURATION #
** ########################
*/

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

app.get("/getOtherUser", function(req, res){
    username = req.body.username;
    pass = req.body.pass;

    var response = getUser();

    res.send(response);
})

app.get("/getMyData", function(){
    username = req.body.username;
    pass = req.body.pass;

    var response = getMyData();

    res.send(response);
})

app.post("/resetPass", function(err, res){
    pass = req.body.pass;

    var response = resetPass();

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
** #############
** # USER DATA #
** #############
*/

function getOtherUser(){

    var userData = {
        Username: username,
        Pool: userPool
    }

    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.getUserAttribute(function(err, res){
        if(err) {
            result = {
                "statusCode" : 400,
                "body" : err.name
            };
        }
        else {
            result = {
                "statusCode" : 200,
                "headers" : "",
                "body" : {
                    "name" : res.name,
                    "surname" : res.surname,
                    "username" : res.username,
                    "message" : "ok"
                }
            };
        }
    })
    return result;
}

function getMyData(){

    var userData = {
        Username: username,
        Pool: userPool
    }

    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.getUserAttribute(function(err, res){
        if(err) {
            result = {
                "statusCode" : 400,
                "body" : err.name
            };
        }
        else {
            result = {
                "statusCode" : 200,
                "headers" : "",
                "body" : {
                    "faculty" : res.faculty,
                    "university" : res.university,
                    "name" : res.name,
                    "surname" : res.surname,
                    "username" : res.username,
                    "message" : "ok"
                }
            };
        }
    })
    return result;
}


/*
** ##################
** # RESET PASSWORD #
** ##################
*/

function resetPass(){

    var attList = []
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({
        AccesToken: "",
        PreviousPassword: pass,
        ProposedPassword: ""
    }));

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
    cognitoUser.changePassword(attList, function(err,res){
        if(err) result = err.name;
        else{
            result = 0;
        }
    })
    return result;
}

/*
** ###############
** #             #
** ###############
*/